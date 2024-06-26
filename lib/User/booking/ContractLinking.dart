import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "0xd4204dba13533fdeadbbc8109c23b6cf8ae2f2854f64d6b4f972421053b3e270";

 late  Web3Client _client;
  late  String _abiCode;

  late  Credentials _credentials;
  late  EthereumAddress _contractAddress;
  late  EthereumAddress _ownAddress;

  late  DeployedContract _contract;
  late  ContractFunction _adopterGetter;
  late  ContractFunction _adoptFunc;
  late  ContractFunction _getAdoptersFunc;

  late  List allAdopters = [];

  late  bool isLoading = true;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("src/contracts/SmartParking.json");
    var jsonFile = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "SmartParking"), _contractAddress);
    _adopterGetter = _contract.function("adopters");
    _adoptFunc = _contract.function("adopt");
    _getAdoptersFunc = _contract.function("getAdopters");
    getAdoptersFunc();
  }

  getAdoptersFunc() async {
    var adopterS = await _client
        .call(contract: _contract, function: _getAdoptersFunc, params: []);
    isLoading = false;
    allAdopters = adopterS.first;
    print(allAdopters[0]);
    notifyListeners();
  }

  Future<String> getAdopter(int id) async {
    var adopterIs = await _client.call(
        contract: _contract,
        function: _adopterGetter,
        params: [BigInt.from(id)])
        ;
    notifyListeners();
    return "${adopterIs.first}";
  }

  adoptFunc(int id, String adopterAddr,String duration,String startTime) async {
    isLoading = false;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _adoptFunc,
            parameters: [
              BigInt.from(id),
              EthereumAddress.fromHex(adopterAddr),
              duration,
              startTime
            ] ,
           maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);
            
    getAdoptersFunc();
  }
}
