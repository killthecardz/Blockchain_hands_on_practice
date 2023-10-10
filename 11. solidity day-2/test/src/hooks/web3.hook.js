import { useState } from "react"

const useWeb3 = ()=>{

    const [user,setUser] = useState({
        account : "",
        balance : "",
    });

    const [web3, setWeb3] = useState(null);

    useEffect(()=>{
        if(window.ethereum){
            window.ethereum.request({
                method : "eth_requestAccounts"
            }).then(([data])=>{
                
            })
        }else{
            alert("메타마스크 설치 하세요~")
        }
    },[])
}