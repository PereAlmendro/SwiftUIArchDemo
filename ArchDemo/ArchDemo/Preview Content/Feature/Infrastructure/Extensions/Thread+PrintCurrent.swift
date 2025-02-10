//
//  Thread+PrintCurrent.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import Foundation

/// Prints information of the current asyncronous context
/// This is useful to test / debug a correct use of async await, tasks, and concurrent programming.
#if DEBUG
extension Thread {
    static func printCurrent(label: String) {
        let name = __dispatch_queue_get_label(nil)
        let queue = String(cString: name, encoding: .utf8) ?? "THREAD DESC: \(Thread.current.description)"

        print("""
----------------------------------------------
LABEL 🏷️: \(label) 
THREAD ⚡️: \(Thread.current)
QUEUE 🍤: \(queue)
PRIORITY 🚦: \(qos_class_self())

""")
    }
}
#endif
