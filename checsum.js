var toChecksumAddress = function(address) {

    var checksumAddress = '0x';
    address = address.toLowerCase().replace('0x', '');

    // creates the case map using the binary form of the hash of the address
    var caseMap = parseInt(web3.sha3('0x' + address), 16).toString(2).substring(0, 40);

    for (var i = 0; i < address.length; i++) {
        if (caseMap[i] == '1') {
            checksumAddress += address[i].toUpperCase();
        } else {
            checksumAddress += address[i];
        }
    }

    console.log('create: ', address, caseMap, checksumAddress)
    return checksumAddress;
};

toChecksumAddress('0x8ccb7d516ccd62312b2d7753b1421ed3862ff80b')