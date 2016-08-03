//
//  ArrayExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func distinct() -> [Element] {
        return [Element](Set(self))
    }
}

extension SequenceType {
    func firstOrDefault(@noescape predicate: (Self.Generator.Element -> Bool)) -> Generator.Element? {
        return self.filter(predicate).first
    }
    
    func categorise<U : Hashable>(@noescape keyFunc: Generator.Element -> U) -> [U : [Generator.Element]] {
        var dict: [U : [Generator.Element]] = [:]
        for element in self {
            let key = keyFunc(element)
            if case nil = dict[key]?.append(element) {
                dict[key] = [element]
            }
        }
        return dict
    }
    
    func sortBy<T: Comparable>(@noescape key: Self.Generator.Element -> T) -> [Self.Generator.Element] {
        return self.sort { key($0) > key($1) }
    }
    
    func skip(count: Int) -> [Generator.Element] {
        let array = Array(self)
        var result: [Self.Generator.Element] = []
        guard count <= array.count else {
            return []
        }
        for index in count..<array.count {
            result.append(array[index])
        }
        return result
    }
    
    func take(count: Int) -> [Generator.Element] {
        let array = Array(self)
        let count = min(count, array.count)
        var result: [Self.Generator.Element] = []
        for index in 0..<count {
            result.append(array[index])
        }
        return result
    }
    
    func any(@noescape predicate: Generator.Element -> Bool) -> Bool {
        for item in self {
            if predicate(item) {
                return true
            }
        }
        return false
    }
    
    func filter<T: Filtering where T.T == Generator.Element>(filter: T) -> [Generator.Element] {
        return self.filter { filter.filter($0) }
    }
    
    func map<T: Convertible where T.TIn == Self.Generator.Element>(converter: T) -> [T.TOut] {
        return self.map { value -> T.TOut in
            return converter.convert(value)
        }
    }
}

extension Array {
    func any() -> Bool {
        return self.count > 0
    }
    
    mutating func remove(@noescape predicate: (Array.Generator.Element -> Bool)) -> Generator.Element? {
        var result: Generator.Element?
        if let index = self.indexOf(predicate) {
            let itemToRemove = self[index]
            self.removeAtIndex(index)
            result = itemToRemove
        }
        return result
    }
    
    mutating func append(elements: [Array.Generator.Element]) {
        for item in elements {
            self.append(item)
        }
    }
    
    func elementAtIndex(index: Int) -> Array.Generator.Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
    
    func splitBy(subSize: Int) -> [[Element]] {
        return 0.stride(to: self.count, by: subSize).map { startIndex in
            let endIndex = startIndex.advancedBy(subSize, limit: self.count)
            return Array(self[startIndex ..< endIndex])
        }
    }
}

extension Array where Element: Equatable {
    
    mutating func appendDistinct(elements: [Element]) {
        for item in elements {
            if self.contains(item) == false {
                self.append(item)
            }
        }
    }
    
    mutating func appendDistinctOrReplace(elements: [Element]) {
        for item in elements {
            if let index = self.indexOf(item) {
                self[index] = item
            } else {
                self.append(item)
            }
        }
    }
    
    mutating func appendDistinct(element: Element) -> Bool {
        guard self.contains(element) == false else {
            return false
        }
        self.append(element)
        return true
    }
    
    mutating func insertDistinct(element: Element, atIndex index: Index) -> Bool {
        guard self.contains(element) == false else {
            return false
        }
        self.insert(element, atIndex: index)
        return true
    }
    
    func previousOf(element: Element) -> Element? {
        guard let index = self.indexOf(element) where index > 0 else {
            return nil
        }
        return self[index - 1]
    }
    
    mutating func remove(element: Element) -> Element? {
        guard let index = self.indexOf(element) else {
            return nil
        }
        return self.removeAtIndex(index)
    }
    
    mutating func replaceWithElement(element: Element) {
        guard let index = self.indexOf(element) else {
            return
        }
        self[index] = element
    }
    
    func replaceElements(elements: [Element]) -> [Element] {
        var result = [Element]()
        for element in self {
            if let index = elements.indexOf(element) {
                result.append(elements[index])
            } else {
                result.append(element)
            }
        }
        return result
    }
}