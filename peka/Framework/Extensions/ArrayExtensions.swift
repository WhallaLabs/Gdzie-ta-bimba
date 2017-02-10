//
//  ArrayExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxOptional

extension Array where Element: Hashable {
    func distinct() -> [Element] {
        return [Element](Set(self))
    }
}

extension Sequence {
    func firstOrDefault(_ predicate: ((Self.Iterator.Element) -> Bool)) -> Iterator.Element? {
        return self.filter(predicate).first
    }
    
    func categorise<U : Hashable>(_ keyFunc: (Iterator.Element) -> U) -> [U : [Iterator.Element]] {
        var dict: [U : [Iterator.Element]] = [:]
        for element in self {
            let key = keyFunc(element)
            if case nil = dict[key]?.append(element) {
                dict[key] = [element]
            }
        }
        return dict
    }
    
    func sortBy<T: Comparable>(_ key: (Self.Iterator.Element) -> T) -> [Self.Iterator.Element] {
        return self.sorted { key($0) > key($1) }
    }
    
    func skip(_ count: Int) -> [Iterator.Element] {
        let array = Array(self)
        var result: [Self.Iterator.Element] = []
        guard count <= array.count else {
            return []
        }
        for index in count..<array.count {
            result.append(array[index])
        }
        return result
    }
    
    func take(_ count: Int) -> [Iterator.Element] {
        let array = Array(self)
        let count = count < array.count ? count : array.count//min(count, array.count) //To jest jakas kpina
        var result: [Self.Iterator.Element] = []
        for index in 0..<count {
            result.append(array[index])
        }
        return result
    }
    
    func any(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        for item in self {
            if predicate(item) {
                return true
            }
        }
        return false
    }
    
    func filter<T: Filtering>(_ filter: T) -> [Iterator.Element] where T.T == Iterator.Element {
        return self.filter { filter.filter($0) }
    }
    
    func map<T: Convertible>(_ converter: T) -> [T.TOut] where T.TIn == Self.Iterator.Element {
        return self.map { value -> T.TOut in
            return converter.convert(value)
        }
    }
}

extension Array {
    func any(_ predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        return self.filter(predicate).isNotEmpty
    }
    
    mutating func remove(_ predicate: ((Array.Iterator.Element) -> Bool)) -> Iterator.Element? {
        var result: Iterator.Element?
        if let index = self.index(where: predicate) {
            let itemToRemove = self[index]
            self.remove(at: index)
            result = itemToRemove
        }
        return result
    }
    
    mutating func append(_ elements: [Array.Iterator.Element]) {
        for item in elements {
            self.append(item)
        }
    }
    
    func elementAtIndex(_ index: Int) -> Array.Iterator.Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
    
    func splitBy(_ subSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: subSize).map { startIndex in
            let endIndex = startIndex.advanced(by: subSize)
            return Array(self[startIndex ..< endIndex])
        }
    }
}

extension Array where Element: Equatable {
    
    mutating func appendDistinct(_ elements: [Element]) {
        for item in elements {
            if self.contains(item) == false {
                self.append(item)
            }
        }
    }
    
    mutating func appendDistinctOrReplace(_ elements: [Element]) {
        for item in elements {
            if let index = self.index(of: item) {
                self[index] = item
            } else {
                self.append(item)
            }
        }
    }
    
    mutating func appendDistinct(_ element: Element) -> Bool {
        guard self.contains(element) == false else {
            return false
        }
        self.append(element)
        return true
    }
    
    mutating func insertDistinct(_ element: Element, atIndex index: Index) -> Bool {
        guard self.contains(element) == false else {
            return false
        }
        self.insert(element, at: index)
        return true
    }
    
    func previousOf(_ element: Element) -> Element? {
        guard let index = self.index(of: element), index > 0 else {
            return nil
        }
        return self[index - 1]
    }
    
    mutating func remove(_ element: Element) -> Element? {
        guard let index = self.index(of: element) else {
            return nil
        }
        return self.remove(at: index)
    }
    
    mutating func replaceWithElement(_ element: Element) {
        guard let index = self.index(of: element) else {
            return
        }
        self[index] = element
    }
    
    func replaceElements(_ elements: [Element]) -> [Element] {
        var result = [Element]()
        for element in self {
            if let index = elements.index(of: element) {
                result.append(elements[index])
            } else {
                result.append(element)
            }
        }
        return result
    }
}
