//
//  TodoError.swift
//  CleanSwift
//
//  Created by Agung Saputra on 17/07/23.
//

import Foundation

enum FetchDataError: Error {
    case DataSourceError, CreateError, DeleteError, UpdateError, FetchError
}
