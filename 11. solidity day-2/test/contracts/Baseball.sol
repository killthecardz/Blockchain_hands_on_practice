// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Baseball{
    // 컨트랙트 배포자
    address private owner;

    // 게임의 횟수
    // constant 구문을 추가하면 상태를 변경하지 않은 상태 변수
    uint256 private constant GAME_COUNT = 5;

    // ticket 게임을 하고싶으면 지불해야하는 이더
    uint256 private ticket = 5 ether;

    // 정답의 값을 담아놓을 변수
    // 컴퓨터가 정할 랜덤값
    // 3자리수의 숫자
    uint256 private random;

    // 게임의 진행도
    uint256 private progress;

    // 총 모여있는 상금
    uint256 private reward;

    // 게임의 현재 상태
    enum GameStatus {
        playing, // 0
        GameOver // 1
    }
    // 최초의 상태값은 0
    // 게임 플레이중 Playing
    GameStatus gameStatus;

    // 컨트랙트 생성자
    // 딱한번 실행되는데
    // 컨트랙트가 배포되면
    constructor(){
        // 최초에 딱한번 배포자가 상태변수에 담기고
        owner = msg.sender;

        // keccak256 : 솔리디티에서 랜덤값을 뽑을 때 사용 매개변수를 해시값으로 변경해준다. SHA-3
        // abi.encodePacked() : 매개변수로 전달된 내용들을 가지고 바이트 배열로 만들어준다.
        random = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)));
        
        // 큰숫자가 나오는데
        // 이 숫자를 가지고 나머지 연산을 통해 원하는 자리수의 숫자를 구하자
        // 100 ~ 999 까지의 범위를 지정을 한다
        random = (random % 900) + 100;
    }

    function gameStart(uint _value) public payable {
        require(progress < GAME_COUNT, "GameOver");
        require(msg.value == ticket, "ticket amount error (5 ether) ");
        require((_value >= 100) && (_value <1000), "_value error");

        progress += 1;

        if(_value == random){
            // 게임 끝 정답
            // CA의 잔액이 보상 만큼있는지 검사
            require(reward <= address(this).balance);
            payable(msg.sender).transfer(address(this).balance);
            reward = 0;
            // gameStatus 상태가 상수값 1로 돌아감
            // 1은 게임이 끝났다는 얘기
            gameStatus = GameStatus.GameOver;
        }else{
            reward += msg.value;
        }
    }

    // 지금 현재 쌓인 보상을 보여줄 함수
    function getReward() public view returns (uint256) {
        return reward;
    }

    function getProgress() public view returns (uint256) {
        return progress;
    }

    function getTicketPrice() public view returns (uint256) {
        return ticket;
    }

    // 어드민 모드
    // 정답을 확인하는 함수
    function getRandom() public view returns(uint256){
        require(owner == msg.sender, "admin");
        return random;
    }

    // 게임중인지 확인할 함수
    function getPlaying() public view returns (uint256) {
        // 게임이 진행되고있는 상수값이 0
        uint256 Playing = 0;
        if((gameStatus != GameStatus.Playing) || (progress == GAME_COUNT)){
            // 게임이 끝났다
            Playing = 1;
        }
        return Playing;
    }
}