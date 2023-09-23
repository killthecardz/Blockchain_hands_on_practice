# 이더리움 개발을 할 때 사용하는 툴

geth : go언어로 작성이 되어있는 이더리움 클라이언트 chainId를 확인 할 수 있는 클라이언트
            chainId 는 블록체인의 고유 식별자이다. 메인넷인지 테스트넷인지 구분을 할 수 있다.
            요약 : geth는 이더리움 노드를 실행하기 위한 소프트웨어이다.

참고 --------------------------------

 Geth는 Ethereum 네트워크와의 연결 및 노드 실행에 주로 사용되는 반면, Ganache, Truffle, Remix 및 Hardhat와 같은 도구들은 스마트 컨트랙트의 개발 및 테스트에 특화되어 있습니다.

 이 중에서 Ganache와 Hardhat은 로컬 테스트 환경을 제공하므로, 개발자가 빠르게 스마트 컨트랙트를 테스트하고 디버깅할 수 있습니다. Truffle과 Remix는 스마트 컨트랙트 개발과 테스트의 전체 프로세스를 지원합니다.

 --------------------------------


# RPC 통신 (Remote Procedure call) 

함수는 자신의 메모리 공간에서 실행되고 ,다른 주소의 메모리 공간에서 동작하는 프로세스 함수를 실행 하고 싶을 때 사용한다

## ganache 설치

npm i -g ganache-cli


## web3 라이브러리 vs geth

web3.js는 사용자의 요청을 Ethereum 네트워크에 전달하는 "중개자" 역할을 하며, geth는 실제로 네트워크와 상호 작용하고 블록체인 데이터를 처리하는 "실행자" 역할을 합니다.


```json
{
    "jsonrpc" : "2.0", // json-RPC 버전 2.0
    "method" : "web3_clientVersion", // 실행 요청할 메서드 명
    "params" : [] // 메서드에 전달을 할 인자값, 매개변수
}
```

- curl
- cli에서 요청을 보낼수 있다

1. -X POST : get인지 post인지 등등 요청 타입
2. -d `{"jsonrpc" : "2.0", "method" : "web3_clientVersion", "params" : []}` : 전달하는 데이터의 내용
3. 마지막은 요청하는 URL 주소
- curl -X POST -d '{"jsonrpc" : "2.0", "method" : "web3_clientVersion", "params" : []}' http://127.0.0.1:8545

- ganache로 이더리움 네트워크 테스트환경에서
- web3_clientVersion 메서드를 실행시키는데
- RPC 통신으로 요청을 보내서 
- 네트워크의 web3_clientVersion 메서드를 실행시키고
- 반환받은 메시지는 {"jsonrpc":"2.0","result":"EthereumJS TestRPC/v2.13.2/ethereum-js"}
- EthereumJS TestRPC/v2.13.2/ethereum-js

- eth.getBalance(매개변수)
- curl -X POST -d '{"jsonrpc" : "2.0", "method" : "eth_getBalance", "params" : ["0x4090833B5fd908eA56408ce366D91446dCD7c4aC"]}' http://127.0.0.1:8545

- eth_getBalance함수를 RPC 통신으로 요청을 해서 
- 계정의 잔액
- {"jsonrpc":"2.0","result":"0x56bc75e2d63100000"}

- web3에서는 getBalance 호출을 하면 10진수로 변환해서 반환 값을 주고
- wei 
- wei -> eth 
- 1eth === 100 x 10e18 wei
- wei = 10**18

# 이더리움 트랜잭션을 발생 시킬때 gas

- 주유소를 예를 들어서
- 리터당 2000

- 4만원 넣는다고 가정하면 20리터

- 리터가 gasPrice : 리터당의 가격 2000
- gas : 가스의 리터당으로 계산 값의 총 가스량에서 우리가 발생시킬수있는 총 제한량

- 트랜잭션 발생시 총 수수료는 gas X gasPrice

- byte당 대략 5gas


# sendTransaction

- curl -X POST -d '{"jsonrpc" : "2.0", "method" : "eth_sendTransaction", "params" : [{"from" : "0x4090833B5fd908eA56408ce366D91446dCD7c4aC","to" : "0xBAC58EbA2958938164d9AE2d12E1d997F58f3a6c","value": "10000000000"}]}' http://127.0.0.1:8545


# web3
- js 라이브러리로, 웹 어플리케이션에서 이더리움 블록체인과 상호작용을 하기 위해 노드에서 요청을 보낼때 API 지정해놓았다.


# 간단하게 컨트랙트 배포

 - 소스 코드 작성에 사용하는 언어 : 솔리디티를 사용할것이고.

 - 컴파일 -> EVM이 실행시킬수 있는 형식(바이트 코드로) 변환

 - 배포 -> 트랜잭션 생성 변환한 바이트 코드와 내용을 포함한 트랜잭션을 생성하고 이더리움 네트워크에 전송
 - 네트워크에 트랜잭션 풀에 담기고 블록 생성되면서 데이터로 저장이 된다. -> 스마트 컨트랙트 배포

 # 기본적인 솔리디티 코드 구조

 1. 라이센스 식별자

 2. 솔리디티 버전

 3. 배포할 컨트랙트


# 솔리디티 코드 컴파일

// solc 라이브러리 설치
- npm i solc@0.8.0

// solc를 사용해서 코드 컴파일
- npx solc --bin --abi ./test.sol  