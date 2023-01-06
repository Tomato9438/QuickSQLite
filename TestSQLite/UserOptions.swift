//
//  UserOptions.swift
//  New
//
//  Created by Tom Bluewater on 11/11/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation

class UserOptions {
    static func createData(path: String) {
        var statement: OpaquePointer? = nil
        sqlite3_open(path, &statement)
        let sqlCreate = "CREATE TABLE IF NOT EXISTS data (ID INTEGER PRIMARY KEY AUTOINCREMENT, field text, value text)"
        sqlite3_exec(statement, (sqlCreate as NSString).utf8String, nil, nil, nil)
        //sqlite3_close(statement)
        
        // Start Inserting fields
        for i in 0..<101 {
            if sqlite3_open(path, &statement) == SQLITE_OK {
                let sqlInsert = "INSERT INTO data (field,value) VALUES (?,?)"
                if sqlite3_prepare_v2(statement, sqlInsert, -1, &statement, nil) != SQLITE_OK {
                    //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                    //print("error preparing insert: \(errMsg)")
                }
                sqlite3_bind_text(statement, 1, "Value" + String(i), -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                
                if i == 0 {
                    sqlite3_bind_text(statement, 2, "0", -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self)) // enter a special value in "0"
                }
                else {
                    sqlite3_bind_text(statement, 2, "0", -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                }
                
                sqlite3_step(statement)
                sqlite3_finalize(statement)
            }
        }
        //sqlite3_close(statement)
        // End Inserting fields
    }
    
    static func openDatabase(path: String) -> OpaquePointer? {
        var db: OpaquePointer? = nil
        if sqlite3_open(path, &db) == SQLITE_OK {
            return db
        } else {
            return nil
        }
    }
    
    static func readData(path: String, field: String) -> String {
        var statement: OpaquePointer? = nil
        var value = String()
        if let open = openDatabase(path: path) {
            let sql = "Select value FROM data WHERE field = ?"
            if sqlite3_prepare_v2(open, sql, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, field, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    value = ((sqlite3_column_text(statement, 0)) != nil) ? String(cString: sqlite3_column_text(statement, 0)) : ""
                }
                sqlite3_finalize(statement)
            }
            sqlite3_close(open)
        }
        return value
    }
    
    static func updateData(path: String, field: String, value: String) {
        var statement: OpaquePointer? = nil
        if let open = openDatabase(path: path) {
            let sql = "UPDATE data SET value = ? WHERE field = ?"
            if sqlite3_prepare_v2(open, sql, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, value, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                sqlite3_bind_text(statement, 2, field, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                //sqlite3_bind_text(statement, 1, value.cString(using: .utf8), -1, nil)
                //sqlite3_bind_text(statement, 2, field.cString(using: .utf8), -1, nil)
                if sqlite3_step(statement) == SQLITE_DONE {
                    //print("DONE!!!")
                } else {
                    print("UGGHH!!!")
                }
                sqlite3_finalize(statement)
            }
            sqlite3_close(open)
        }
    }
}

/*
 Value0 - not used
 Value1 - not used
 Value2 - firebase device token
 Value3 - login email address
 Value4 - login password
 Value5 - menu bio on or off
 Value6 - 口座開設受付番号
 Value7 - ログイン履歴
 Value8 - 
 Value9 -
 Value10 -
 Value11 -
 Value12
 Value13
 Value14
 Value15
 Value16
 Value17
 Value18
 Value19
 Value20
 Value21
 Value22
 Value23
 Value24
 Value25
 Value26
 Value27
 Value28
 Value29
 Value30
 Value31
 Value32
 Value33
 Value34
 Value35
 Value36
 Value37
 Value38
 Value39
 Value40
 */

/*
READ: let opt1 = UserOptions.readData(path: optionFile, field: "Value1")
WRITE: UserOptions.updateData(path: optionFile, field: "Value1", value: newStr)
*/

