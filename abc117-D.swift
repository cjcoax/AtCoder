import Foundation

class Scanner {
    static func readInt() -> Int {
        return Int(readLine()!)!
    }
    
    static func readIntArr() -> [Int] {
        return readLine()!.split(separator: " ").map { Int($0)! }
    }
    
    static func readM(_ n: Int) -> [[Int]] {
        var res = [[Int]]()
        for _ in 0..<n {
            res.append(readIntArr())
        }
        return res
    }
    
    static func readUknownIntMat() -> [[Int]] {
        var res = [[Int]]()
        while let line = readLine() {
            res.append(line.split(separator: " ").map { Int($0)! })
        }
        return res
    }
    
    static func readString() -> String {
        return readLine()!
    }
}

class Printer {
    static func printIntArray(_ arr: [Int]) {
        print(arr.map { String($0) }.joined(separator: " "))
    }
}
class Solution {
    var zeros = [Int](repeating: 0, count: 64)
    var ones = [Int](repeating: 0, count: 64)
    var can = [Int](repeating: 0, count: 64)
    var dp = [[Int]](repeating: [Int](repeating: -1, count: 2), count: 64)
    var n = 0
    var total = 0
    func maxXXOR(_ arr: [Int], _ k: Int, _ total: Int) -> Int {
        guard k > 0 else {
            return arr.reduce(0) { $0 + $1 }
        }
        
        self.total = total
        //how many sets maximum we can set
        self.n = Int(log(Double(k))/log(Double(2))) + 1
        for i in stride(from: 0, to: 64, by: 1) {
            let j = 1<<i
            if k&j == j {
                can[i] = 1
            }
            for num in arr {
                if num&j == 0 {
                    zeros[i] += 1
                } else {
                    ones[i] += 1
                }
            }
        }
        
        var res = dfs(n-1, true)
        for i in stride(from: n, to: ones.count, by: 1) {
            let j = 1<<i
            res += j * ones[i]
        }
        return res
    }
    
    func dfs(_ pos: Int,_ isOnBorder: Bool) -> Int {
        guard pos >= 0 else {
            return 0
        }
        
        guard dp[pos][isOnBorder ? 1 : 0] == -1 else {
            return dp[pos][isOnBorder ? 1 : 0]
        }
        //1 0 0 1
        //^
        let cur = 1<<pos
        var res = 0
        if isOnBorder {
            if can[pos] == 1 {
                res = max(cur * zeros[pos] + dfs(pos-1, true), cur * ones[pos] + dfs(pos-1, false))
            } else {
                res = max(res, cur * ones[pos] + dfs(pos-1, true))
            }
        } else {
            res = cur * max(zeros[pos], ones[pos]) + dfs(pos-1, false)
        }
        dp[pos][isOnBorder ? 1 : 0] = res
        return res
    }
}


let nk = Scanner.readIntArr()
let arr = Scanner.readIntArr()
print(Solution().maxXXOR(arr,nk[1], nk[0]))
