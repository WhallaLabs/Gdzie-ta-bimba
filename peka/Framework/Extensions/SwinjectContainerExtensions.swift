//
//  SwinjectContainerExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import Swinject

extension Container {
    func registerPerContainerLifetime<Service>(_ serviceType: Service.Type, name: String? = nil, factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        var instance: Service?
        return self.register(serviceType, name: name) { resolver in
            if instance == nil {
                instance = factory(resolver)
            }
            return instance!
        }
    }
}
