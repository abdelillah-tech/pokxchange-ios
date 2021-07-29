//
//  TradeViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/4/21.
//

import Foundation

class TradeViewModel: ObservableObject {
    
    @Published var tradePendings: [TradePending] = []
    @Published private(set) var state = LoaderState<TradePending>.idle
    private let defaults = UserDefaults.standard
    let groupTwo = DispatchGroup()
    
    func tradePendingToItemData(token: String, pending: Trade, completion: @escaping (TradePending) -> Void) {
        var sender: User?
        var myCard: Card?
        var exchangeCard: Card?
        
        let group = DispatchGroup()
        
        group.enter()
        UserWebService().getUserById(token: token, id: pending.trader.id) {
            result in
            switch result {
            case .success(let user):
                sender = user
                group.leave()
            case .failure(_): break
            }
        }
        group.enter()
        CardWebService().getCardById(token: token, id: pending.recipient.card.cardId) { result in
            switch result {
            case .success(let card):
                myCard = card
                group.leave()
            case .failure(_): break
            }
        }
        group.enter()
        CardWebService().getCardById(token: token, id: pending.trader.card.cardId) { result in
            switch result {
            case .success(let card):
                exchangeCard = card
                group.leave()
            case .failure(_): break
            }
        }
        group.notify(queue: .main) {
            completion(TradePending(tradeId: pending.id,
                                    sender: sender!,
                                    myCard: myCard!,
                                    exchangeCard: exchangeCard!))
        }
    }
    
    func tradeToPendings(token: String, pendings: [Trade], completion: @escaping ([TradePending]) -> Void) {
        var tradePendings: [TradePending] = []
        
        let group = DispatchGroup()
        
        pendings.forEach { pending in
            group.enter()
            self.tradePendingToItemData(token: token, pending: pending) { pending in
                tradePendings.append(pending)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(tradePendings)
        }
    }
    
    func loadTradePendings(id: UUID) {
        state = .loading
        
        let group = DispatchGroup()
        
        
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        
        TradeWebService().getTradePendings(token: token, id: id) { [weak self] result in
            switch result {
            case .success(let tradePendings):
                var pendings: [TradePending] = []
                
                
                if(!tradePendings.isEmpty){
                    group.enter()
                    tradePendings.forEach { pending in
                        self?.tradePendingToItemData(token: token, pending: pending) { pending in
                            pendings.append(pending)
                            group.leave()
                        }
                    }
                    group.notify(queue: .main) {
                        self?.state = .loaded(pendings)
                        self?.tradePendings = pendings
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.state = .loaded(pendings)
                        self?.tradePendings = pendings
                    }
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
            
        }
    }
    
    func approveTradeRequest(recipientId: UUID,
                             tradeId: UUID) {
        let validation = TradeValidation(tradeId: tradeId, recipientId: recipientId)
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        TradeWebService().approveTradeRequest(token: token, validation: validation) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.loadTradePendings(id: myIdGetter()!)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func sendTradeRequest(myId: UUID,
                          userId: UUID,
                          myCollectedCard: CollectedCard,
                          userCollectedCard: CollectedCard) {
        let trader = Trader(id: myId, card: myCollectedCard)
        let recipient = Trader(id: userId, card: userCollectedCard)
        let proposal = TradeProposal(trader: trader, recipient: recipient)
        
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        TradeWebService().sendTradeRequest(token: token,
                                           proposal: proposal) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func cancelTradeRequest(recipientId: UUID,
                            tradeId: UUID) {
        let validation = TradeValidation(tradeId: tradeId, recipientId: recipientId)
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        TradeWebService().cancelTradeRequest(token: token, validation: validation) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.loadTradePendings(id: myIdGetter()!)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
