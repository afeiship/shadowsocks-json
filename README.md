# shadowsocks-json
> Export shadowsocks json file.

## install:
```shell
bundle install
whenever --update-crontab
```

## use ss-local:
```shell
brew install shadowsocks-libev
```

## ss-local + privoxy
1. brew install privoxy
2. brew services start privoxy
3. check:
    ```shell
    ps aux  | grep privoxy
    lsof -i:8118
    ```
4. set mac network proxies:
    
    <img width="500" src="https://ws2.sinaimg.cn/large/006tKfTcgy1g12t47c72hj30us0hugom.jpg" />
    
5. start `ss-local` listen:
    ```shell
    ss-local -c /Users/feizheng/github/shadowsocks-json/ss-local.config.json
    ```
    
6. mac set network proxy by cli:
    ```shell
    networksetup -setwebproxy "Wi-fi" 127.0.0.1 8118
    networksetup -setsecurewebproxy "Wi-fi" 127.0.0.1 8118
    ```
    
7. OR user chrome extension: `SwitchyOmega`

    <img width="500" src="https://ws2.sinaimg.cn/large/006tKfTcgy1g12u48l691j31w20o0gqf.jpg"/>


## resources:
- https://github.com/shadowsocks/shadowsocks-libev
- http://www.cnblogs.com/LiLihongqiang/p/5943889.html
- https://www.zfl9.com/ss-local.html
