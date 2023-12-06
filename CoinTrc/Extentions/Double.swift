//
//  Double.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 6/12/23.
//

import Foundation

extension Double {
    //convert a Double into currency with 2 decimal places
    private var currencyFormatter2 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    //convert a Double into currency as a String with 2 decimal places
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    //convert a Double into currency with 2-6 decimal places
    private var currencyFormatter6 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    //convert a Double into currency as a String with 2-6 decimal places
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    //convert a Double into String representation
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    //convert a Double into String representation with percent symbol
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
