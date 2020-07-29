//https://atcoder.jp/contests/dp/tasks/dp_o
#include <unordered_set>
#include <unordered_map>
#include <algorithm>
#include <iostream>
#include <iterator>
#include <numeric>
#include <sstream>
#include <fstream>
#include <cassert>
#include <climits>
#include <cstdlib>
#include <cstring>
#include <string>
#include <cstdio>
#include <vector>
#include <bitset>
#include <cmath>
#include <queue>
#include <tuple>
#include <deque>
#include <stack>
#include <list>
#include <map>
#include <set>
using namespace std;

using ll=long long;

typedef long long ll;
typedef pair<int,int> ii;
typedef pair<string,int> si;
typedef pair<int,ii> iii;
typedef vector <si> vsi;
typedef vector <ii> vii;
typedef vector <int> vi;
typedef vector <ll> vll;
typedef vector <vll> vl2d;
typedef vector <vi> vi2d;
typedef vector <char> vc;
typedef vector <bool> vb;
typedef vector <string> vs;
typedef map <string,vs> msvs;
typedef map <string,int> msi;
typedef map <char,int> mci;
typedef map <int,int> mii;
typedef map <long,long> ml;
typedef map <string,string> mss;
#define rep(i,a,n) for (ll i=a;i<n;i++)
#define per(i,a,n) for (ll i=n-1;i>=a;i--)
//Swift related stuff

#define guard(_condition) if (bool(_condition)){}

ll dp[21][1<<21];
vl2d match(21, vll(21,0));
ll n;

void addSelf(ll &a, ll b) {
    a = a+b;
    if(a>=1000000007) {
        a-=1000000007;
    }
}

ll solve(ll mi, ll mask) {
    guard(dp[mi][mask] == -1) else {
        return dp[mi][mask];
    }
    guard(mi<n-1) else {
        rep(i,0,n) {
            guard(match[mi][i] && ((1<<i) & mask) == 0) else {
                continue;
            }
            return 1;
        }
        return 0;
    }
    
    ll res = 0ll;
    rep(i,0,n) {
        guard(match[mi][i] == 1 && ((1<<i) & mask) == 0) else {
            continue;
        }
        addSelf(res, solve(mi+1, mask|(1<<i)));
    }
    dp[mi][mask] = res;
    return res;
}

int main() {
    memset(dp, -1, sizeof dp);
    cin>>n;
    rep(i,0,n) {
        rep(j,0,n) {
            cin>>match[i][j];
        }
    }
    cout<<solve(0,0)<<endl;
    return 0;
}
