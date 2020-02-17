//
//  Piece.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Piece: NSObject {
    // The owner of the piece
    public var owner: Player
    
    // Record the current position/coorditate of the piece in the board matrix
    public var position: Vector
    
    // The status of the piece
    public var status: PieceStatus
    
    // Helper property: pid
    public var pid: Int
    static var count: Int = 0
    
    private static func generatePid() -> Int {
        count += 1
        return count
    }
    
    // Constructor
    init(_ owner: Player, _ position: Vector) {
        self.owner = owner
        self.position = position
        self.status = .Alive
        self.pid = Piece.generatePid()
    }
    
    public func setPosition(_ position: Vector) {
        self.position = position
    }
    
    public func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
        return []
    }

    func isValidMove(_ move: Vector, _ boardStates: [[Piece?]]) -> Bool {
        return false
    }
}
