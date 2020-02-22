//
//  ServiceLocator.swift
//  KinoPub
//
//  Created by Maksim Kolesnik on 22/02/2020.
//  Copyright © 2020 Maksim Kolesnik. All rights reserved.
//

import Foundation
import Combine

public final class ServiceLocator {
    static let shared = ServiceLocator()
    
    var keyChainStorage: KeyValueStorage {
        return KeyChainStorage()
    }
    
}
