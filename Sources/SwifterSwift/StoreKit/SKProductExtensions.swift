// SKProductExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(StoreKit)
import StoreKit

@available(watchOS 6.2, *)
public extension SKProduct {
    private static let priceFormatter: NumberFormatter = {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        return priceFormatter
    }()

    /// SS: 商品价格的本地化字符串
    var localizedPrice: String? {
        let formatter = SKProduct.priceFormatter
        formatter.locale = priceLocale
        return formatter.string(from: price)
    }
}
#endif
