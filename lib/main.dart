import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart' as flFramework;
import 'package:flutter/src/widgets/basic.dart' as flPadding;
import 'dart:convert';
import 'dart:typed_data';
import 'package:hex/hex.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webcrypto/webcrypto.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Console'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

// widget class
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends flFramework.State<MyWidget> {
  // state variable
  String _textString = 'press the button "run the code"';

  late KeyPair<EcdhPrivateKey, EcdhPublicKey> keyPair;
  late Uint8List derivedBits;
  late AesGcmSecretKey aesGcmSecretKey;
  final Uint8List iv = Uint8List.fromList('Initialization Vector'.codeUnits);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'console output',
          style: TextStyle(fontSize: 30),
        ),
        Expanded(
          flex: 1,
          child: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: flPadding.Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(_textString,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                      color: Colors.black,

                    ))),
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  child: Text('clear console'),
                  onPressed: () {
                    clearConsole();
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  child: Text('extra Button'),
                  onPressed: () {
                    runYourSecondDartCode();
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  child: Text('run the code'),
                  onPressed: () async {
                    runYourMainDartCode();
                  },
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  void clearConsole() {
    setState(() {
      _textString = ''; // will add additional lines
    });
  }

  void printC(_newString) {
    setState(() {
      _textString =
          _textString + _newString + '\n';
      print(_newString); // extra printing on concole
    });
  }
  /* ### instructions ###
      place your code inside runYourMainDartCode and print it to the console
      using printC('your output to the console');
      clearConsole() clears the actual console
      place your code that needs to be executed additionally inside
      runYourSecondDartCode and start it with "extra Button"
   */
  Future<String> runYourMainDartCode() async  {

    clearConsole();

    printC('webcrypto ECDH example');
    _completeRunOwn();


    /*

    printC('Chacha20-Poly1305 String encryption with PBKDF2 derived key\n');
    final plaintext = 'The quick brown fox jumps over the lazy dog';

    printC('plaintext: ' + plaintext);
    final password = 'secret password';

    printC('\nAES GCM 256');
    // encryption
    printC('\n* * * Encryption * * *');
    //String ciphertextBase64 = aesGcmPbkdf2EncryptToBase64(password, plaintext);
    String ciphertextBase64 = 'not used';
    printC('ciphertext (Base64): ' + ciphertextBase64);
    printC('output is (Base64) salt : (Base64) nonce : (Base64) ciphertext : (Base64) gcmTag');

    printC('\n* * * Decryption * * *');
    var ciphertextDecryptionBase64 = ciphertextBase64;
    printC('ciphertext (Base64): ' + ciphertextDecryptionBase64);
    printC('input is (Base64) salt : (Base64) nonce : (Base64) ciphertext : (Base64) gcmTag');
    //var decryptedtext = aesGcmPbkdf2DecryptFromBase64(password, ciphertextDecryptionBase64);
    var decryptedtext = 'not used';
    printC('plaintext:  ' + decryptedtext);

    printC('\nChacha20Poly1305');
    printC('\n* * * Encryption * * *');
    ciphertextBase64 = chacha20Poly1305Pbkdf2EncryptToBase64(password, plaintext);
    printC('ciphertext (Base64): ' + ciphertextBase64);
    printC('output is (Base64) salt : (Base64) nonce : (Base64) ciphertext : (Base64) macTag');

    printC('\n* * * Decryption * * *');
    ciphertextDecryptionBase64 = ciphertextBase64;
    printC('ciphertext (Base64): ' + ciphertextDecryptionBase64);
    printC('input is (Base64) salt : (Base64) nonce : (Base64) ciphertext : (Base64) macTag');
    decryptedtext = chacha20Poly1305Pbkdf2DecryptFromBase64(password, ciphertextDecryptionBase64);
    printC('plaintext:  ' + decryptedtext);

    printC('\nChacha20Poly1305 Argon2id');
    printC('\n* * * Encryption * * *');
    ciphertextBase64 = await chacha20Poly1305Argon2idEncryptToBase64(password, plaintext);
    printC('ciphertext (Base64): ' + ciphertextBase64);
    printC('output is (Base64) salt : (Base64) nonce : (Base64) ciphertext : (Base64) macTag');
    printC('\n* * * Decryption * * *');
    ciphertextDecryptionBase64 = ciphertextBase64;
    printC('ciphertext (Base64): ' + ciphertextDecryptionBase64);
    printC('input is (Base64) salt : (Base64) nonce : (Base64) ciphertext : (Base64) macTag');
    decryptedtext = await chacha20Poly1305Argon2idDecryptFromBase64(password, ciphertextDecryptionBase64);
    printC('plaintext:  ' + decryptedtext);

     */
  return '';
  }

  void runYourSecondDartCode() {
    printC('execute additional code');
  }

  Future<void> _completeRunOwn() async {
    // final digest = await Hash.sha256.digestBytes(utf8.encode('Hello World'));
    // print(base.encode(digest));

    printC('ECDH own');

    // 1. Generate keys
    printC('1 generate keys');
    KeyPair<EcdhPrivateKey, EcdhPublicKey> keyPairA =
         await EcdhPrivateKey.generateKey(EllipticCurve.p256);
    Map<String, dynamic> publicKeyJwkA = await keyPairA.publicKey.exportJsonWebKey();
    Map<String, dynamic> privateKeyJwkA = await keyPairA.privateKey.exportJsonWebKey();

    KeyPair<EcdhPrivateKey, EcdhPublicKey> keyPairB =
      await EcdhPrivateKey.generateKey(EllipticCurve.p256);
    Map<String, dynamic> publicKeyJwkB = await keyPairB.publicKey.exportJsonWebKey();
    Map<String, dynamic> privateKeyJwkB = await keyPairB.privateKey.exportJsonWebKey();


    printC('ECDH Private A: ');
    printC(privateKeyJwkA.toString());
    printC('ECDH Public A: ');
    printC(publicKeyJwkA.toString());
    printC('ECDH Private B: ');
    printC(privateKeyJwkB.toString());
    printC('ECDH Public B: ');
    printC(publicKeyJwkB.toString());


    // 2. Derive bits A
    printC('2 derive bits A');
    //Map<String, dynamic> publicjwk = json.decode('{"kty": "EC", "crv": "P-256", "x": "31MyHDPKNllGkr56jvpH_8wpBkKMtqgcQqBM7ZjPHc4", "y": "DMrG4SnjNFEsHOPjtA7JCfkji51c81jno2AgQ37AYDQ"}');
    // reload the key from JWK/Json
    EcdhPublicKey ecdhPublicKeyB =
    await EcdhPublicKey.importJsonWebKey(publicKeyJwkB, EllipticCurve.p256);
    //Map<String, dynamic> privatejwk = json.decode('{"kty": "EC", "crv": "P-256", "x": "WnVvrbooqRiw88JyFAGpuX0uc1wTsAUXTSx6GH4lMwU", "y": "u42IFm9ZGKQrsdXZEZAR2RJJvlPNLwMfHQveIP6NX8U", "d": "GUwEOAb4z7R4XugKf-I-sBSLsbCa4ViLlZym9Zg8pgM"}');
    EcdhPrivateKey ecdhPrivateKeyA =
    await EcdhPrivateKey.importJsonWebKey(privateKeyJwkA, EllipticCurve.p256);
    Uint8List derivedBitsA = await ecdhPrivateKeyA.deriveBits(256, ecdhPublicKeyB);
    printC('derivedBitsA: ' + HEX.encode(derivedBitsA));

    // 3. Encrypt A
    printC('3. Encrypt A');
    AesGcmSecretKey aesGcmSecretKeyA = await AesGcmSecretKey.importRawKey(derivedBitsA);
    List<int> list = 'The lazy fox'.codeUnits;
    Uint8List data = Uint8List.fromList(list);
    // generate a random iv
    final iv = Uint8List(12);
    printC('iv Hex   : ' + HEX.encode(iv));
    fillRandomBytes(iv);
    printC('iv Hex   : ' + HEX.encode(iv));
    //Uint8List iv = Uint8List.fromList('Initializati'.codeUnits);
    Uint8List encryptedBytes = await aesGcmSecretKeyA.encryptBytes(data, iv);
    printC('encryptedBytes Hex   : ' + HEX.encode(encryptedBytes));
    printC('encryptedBytes Base64: ' + base64Encode(encryptedBytes));

    // String encryptedString = String.fromCharCodes(encryptedBytes);

    print('*** now decryption part');

    // 4. Derive bits B
    printC('4 derive bits B');
    //Map<String, dynamic> publicjwk = json.decode('{"kty": "EC", "crv": "P-256", "x": "31MyHDPKNllGkr56jvpH_8wpBkKMtqgcQqBM7ZjPHc4", "y": "DMrG4SnjNFEsHOPjtA7JCfkji51c81jno2AgQ37AYDQ"}');
    // reload the key from JWK/Json
    EcdhPublicKey ecdhPublicKeyA =
    await EcdhPublicKey.importJsonWebKey(publicKeyJwkA, EllipticCurve.p256);
    //Map<String, dynamic> privatejwk = json.decode('{"kty": "EC", "crv": "P-256", "x": "WnVvrbooqRiw88JyFAGpuX0uc1wTsAUXTSx6GH4lMwU", "y": "u42IFm9ZGKQrsdXZEZAR2RJJvlPNLwMfHQveIP6NX8U", "d": "GUwEOAb4z7R4XugKf-I-sBSLsbCa4ViLlZym9Zg8pgM"}');
    EcdhPrivateKey ecdhPrivateKeyB =
    await EcdhPrivateKey.importJsonWebKey(privateKeyJwkB, EllipticCurve.p256);
    Uint8List derivedBitsB = await ecdhPrivateKeyB.deriveBits(256, ecdhPublicKeyA);
    printC('derivedBitsB: ' + HEX.encode(derivedBitsB));

    // 5. Decrypt
    printC('5 decrypt with wrong IV');
    AesGcmSecretKey aesGcmSecretKeyB =
    await AesGcmSecretKey.importRawKey(derivedBitsB);
    try {
      Uint8List decryptdBytes = await aesGcmSecretKeyB.decryptBytes(
          encryptedBytes,
          Uint8List.fromList('Initialization Vector'.codeUnits));
      String decryptdString = String.fromCharCodes(decryptdBytes);
      printC('decryptedString: ' + decryptdString);
    } on Error {
      printC('error during decryption');
    };

    printC('6 decrypt with correct IV');
    try {
      Uint8List decryptdBytes = await aesGcmSecretKeyB.decryptBytes(
          encryptedBytes,
          iv);
      String decryptdString = String.fromCharCodes(decryptdBytes);
      printC('decryptedString: ' + decryptdString);
    } on Error {
      printC('error during decryption');
    };

    //printC('decrypted string is $decryptdString');
  }

  Future<void> _completeRun() async {
    // final digest = await Hash.sha256.digestBytes(utf8.encode('Hello World'));
    // print(base.encode(digest));
    // 1. Generate keys
    // KeyPair<EcdhPrivateKey, EcdhPublicKey> keyPair =
    //     await EcdhPrivateKey.generateKey(EllipticCurve.p256);
    // Map<String, dynamic> publicKeyJwk =
    //     await keyPair.publicKey.exportJsonWebKey();
    // Map<String, dynamic> privateKeyJwk =
    //     await keyPair.privateKey.exportJsonWebKey();

    // 2. Derive bits
    Map<String, dynamic> publicjwk = json.decode(
        '{"kty": "EC", "crv": "P-256", "x": "31MyHDPKNllGkr56jvpH_8wpBkKMtqgcQqBM7ZjPHc4", "y": "DMrG4SnjNFEsHOPjtA7JCfkji51c81jno2AgQ37AYDQ"}');
    EcdhPublicKey ecdhPublicKey =
    await EcdhPublicKey.importJsonWebKey(publicjwk, EllipticCurve.p256);
    Map<String, dynamic> privatejwk = json.decode(
        '{"kty": "EC", "crv": "P-256", "x": "WnVvrbooqRiw88JyFAGpuX0uc1wTsAUXTSx6GH4lMwU", "y": "u42IFm9ZGKQrsdXZEZAR2RJJvlPNLwMfHQveIP6NX8U", "d": "GUwEOAb4z7R4XugKf-I-sBSLsbCa4ViLlZym9Zg8pgM"}');
    EcdhPrivateKey ecdhPrivateKey =
    await EcdhPrivateKey.importJsonWebKey(privatejwk, EllipticCurve.p256);
    Uint8List derivedBits = await ecdhPrivateKey.deriveBits(256, ecdhPublicKey);

    // 3. Encrypt
    AesGcmSecretKey aesGcmSecretKey =
    await AesGcmSecretKey.importRawKey(derivedBits);
    // List<int> list = 'hello'.codeUnits;
    // Uint8List data = Uint8List.fromList(list);
    // Uint8List iv = Uint8List.fromList('Initialization Vector'.codeUnits);
    // Uint8List encryptedBytes = await aesGcmSecretKey.encryptBytes(data, iv);
    // String encryptedString = String.fromCharCodes(encryptedBytes);

    // 4. Decrypt
    Uint8List decryptdBytes = await aesGcmSecretKey.decryptBytes(
        Uint8List.fromList('P^-Uº-¬"ë¦ìÂ='.codeUnits),
        Uint8List.fromList('Initialization Vector'.codeUnits));
    String decryptdString = String.fromCharCodes(decryptdBytes);

    // print(
    //     'keypair $keyPair, $publicKeyJwk, $privateKeyJwk, $encryptedString, $decryptdString');

    //print('encrypted strring is $encryptedString');
    printC('decrypted string is $decryptdString');
  }


  Future<void> generateKeys() async {
    final prefs = await SharedPreferences.getInstance();
    String derivedBitsString = (prefs.getString('derivedBits') ?? '');
    if (derivedBitsString.isNotEmpty) {
      derivedBits = Uint8List.fromList(derivedBitsString.codeUnits);
      print('derivedBits present');
      return;
    }

    // 1. Generate keys
    keyPair = await EcdhPrivateKey.generateKey(EllipticCurve.p256);
    Map<String, dynamic> publicKeyJwk =
    await keyPair.publicKey.exportJsonWebKey();
    Map<String, dynamic> privateKeyJwk =
    await keyPair.privateKey.exportJsonWebKey();

    print('keypair $keyPair, $publicKeyJwk, $privateKeyJwk');

    deriveBits();
  }

  Future<void> deriveBits() async {
    // 2. Derive bits
    derivedBits = await keyPair.privateKey.deriveBits(256, keyPair.publicKey);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('derivedBits', String.fromCharCodes(derivedBits));
    print('derivedBits $derivedBits');
  }

  Future<String> encrypt(String message) async {
    // 3. Encrypt
    aesGcmSecretKey = await AesGcmSecretKey.importRawKey(derivedBits);
    List<int> list = message.codeUnits;
    Uint8List data = Uint8List.fromList(list);
    Uint8List encryptedBytes = await aesGcmSecretKey.encryptBytes(data, iv);
    String encryptedString = String.fromCharCodes(encryptedBytes);

    print('encryptedString $encryptedString');
    return encryptedString;
  }

  Future<String> decrypt(String encryptedMessage) async {
    // 4. Decrypt
    aesGcmSecretKey = await AesGcmSecretKey.importRawKey(derivedBits);
    List<int> message = Uint8List.fromList(encryptedMessage.codeUnits);
    Uint8List decryptdBytes = await aesGcmSecretKey.decryptBytes(message, iv);
    String decryptdString = String.fromCharCodes(decryptdBytes);

    print('decryptdString $decryptdString');
    return decryptdString;
  }
}