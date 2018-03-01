{
    "id": "3623bef4-08cc-4b70-b4f9-a2ce29cb51ac",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "griefer_client",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": -1,
    "date": "2018-49-27 11:02:54",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "a3bf90c5-640d-4f46-bfc4-a0f6d4f70604",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 17593040736494,
            "filename": "GriefPlusPlus.dll",
            "final": "",
            "functions": [
                {
                    "id": "b9503706-a266-48a5-bfd3-3d990cc857e1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "startMatchMaking",
                    "help": "",
                    "hidden": false,
                    "kind": 12,
                    "name": "startMatchMaking",
                    "returnType": 2
                },
                {
                    "id": "695e0adb-8ccb-4654-9646-438c27dc6877",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "leaveMatchMaking",
                    "help": "",
                    "hidden": false,
                    "kind": 12,
                    "name": "leaveMatchMaking",
                    "returnType": 2
                },
                {
                    "id": "de71e8d8-d896-4446-aee5-c9dc813e93d8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "logIn",
                    "help": "",
                    "hidden": false,
                    "kind": 12,
                    "name": "logIn",
                    "returnType": 2
                },
                {
                    "id": "25f7ea82-31b2-468d-b4dc-75d697a07fed",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        2,
                        2
                    ],
                    "externalName": "objUpdateReal",
                    "help": "newObjUpdateReal(oid_string, netVar, value, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "newObjUpdateReal",
                    "returnType": 2
                },
                {
                    "id": "d97e737a-b747-4db4-b675-bdfe71e8761c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        2
                    ],
                    "externalName": "objUpdateStr",
                    "help": "newObjUpdateString(oid_string, netVar, value, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "newObjUpdateString",
                    "returnType": 2
                },
                {
                    "id": "0d20ea20-a47e-4167-92ba-c35996d13e6d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        2,
                        2
                    ],
                    "externalName": "objPushBackReal",
                    "help": "newObjPushBackReal(oid_string, netVar, value, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "newObjPushBackReal",
                    "returnType": 2
                },
                {
                    "id": "cbf8d07e-d3ca-4f98-8e8c-9e383c40d4fb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        2
                    ],
                    "externalName": "objPushBackStr",
                    "help": "newObjPushBackString(oid_string, netVar, value, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "newObjPushBackString",
                    "returnType": 2
                },
                {
                    "id": "76b55f4b-9861-4d9f-bf5b-79edb763c0c8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "logOut",
                    "help": "logOut()",
                    "hidden": false,
                    "kind": 12,
                    "name": "logOut",
                    "returnType": 2
                },
                {
                    "id": "951326a2-5d2f-4bd3-aaac-edcdb1ab1b7f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        1,
                        2,
                        2
                    ],
                    "externalName": "objCreate",
                    "help": "objCreate(object_index, uniqueId, myX, myY)",
                    "hidden": false,
                    "kind": 12,
                    "name": "objCreate",
                    "returnType": 2
                },
                {
                    "id": "c9f4a9e5-c6ba-475b-bcb1-33491f2ac539",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "pkgCreate",
                    "help": "pkgCreate()",
                    "hidden": false,
                    "kind": 12,
                    "name": "pkgCreate",
                    "returnType": 2
                },
                {
                    "id": "f1846e0e-e4cf-445b-bb0b-e74611e78f3f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "pkgSend",
                    "help": "pkgSend()",
                    "hidden": false,
                    "kind": 12,
                    "name": "pkgSend",
                    "returnType": 2
                },
                {
                    "id": "efe8d7ea-3e37-43e2-a999-ac641274ccf5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "isString",
                    "help": "isString(mtype)",
                    "hidden": false,
                    "kind": 12,
                    "name": "isString",
                    "returnType": 2
                },
                {
                    "id": "67f4db42-b6b3-499e-af97-1dc39e104917",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "genMessagesWaiting",
                    "help": "genMessagesWaiting()",
                    "hidden": false,
                    "kind": 12,
                    "name": "genMessagesWaiting",
                    "returnType": 2
                },
                {
                    "id": "413f250a-84a4-4d65-b96b-4e2bd6876a5a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readGenMessage",
                    "help": "readGenMessage()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readGenMessage",
                    "returnType": 1
                },
                {
                    "id": "aa2754b0-0197-4cfd-8b4a-25ff76050f6c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readGenValReal",
                    "help": "readGenValReal()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readGenValReal",
                    "returnType": 2
                },
                {
                    "id": "0b213ee1-e3e0-4e4b-87aa-dce4fcc7a531",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readGenValStr",
                    "help": "readGenValStr()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readGenValStr",
                    "returnType": 1
                },
                {
                    "id": "cf42e472-faca-4195-b449-926cc4d314fa",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "objUpdatesWaiting",
                    "help": "objUpdatesWaiting()",
                    "hidden": false,
                    "kind": 12,
                    "name": "objUpdatesWaiting",
                    "returnType": 2
                },
                {
                    "id": "7b559db6-eb2d-4e06-ab7e-3aa0040bc1d4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateIndex",
                    "help": "readObjUpdateIndex()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateIndex",
                    "returnType": 2
                },
                {
                    "id": "10176eb6-5276-4166-8582-d654510c0b8f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateUniqueId",
                    "help": "readObjUpdateUniqueId()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateUniqueId",
                    "returnType": 1
                },
                {
                    "id": "9a61bee3-388a-4bed-b007-c4a202b35521",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateNetvar",
                    "help": "readObjUpdateNetvar()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateNetvar",
                    "returnType": 1
                },
                {
                    "id": "fdee866d-1e42-42e9-a3b5-d105bd9c827f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateValReal",
                    "help": "readObjUpdateValReal()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateValReal",
                    "returnType": 2
                },
                {
                    "id": "cb6d9355-314a-443a-bee5-8f3ae5aa183c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateValStr",
                    "help": "readObjUpdateValStr()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateValStr",
                    "returnType": 1
                },
                {
                    "id": "0edc3d3b-7069-4859-989b-a17067b180a8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjCreateIndex",
                    "help": "readObjCreateIndex()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjCreateIndex",
                    "returnType": 2
                },
                {
                    "id": "a6e5fee6-25db-44d5-b5d9-71ab9e9e2f00",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjCreateUniqueId",
                    "help": "readObjCreateUniqueId()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjCreateUniqueId",
                    "returnType": 1
                },
                {
                    "id": "bb8a26c3-6d7c-4a01-83e8-f11c74271b55",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjCreateMyX",
                    "help": "readObjCreateMyX()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjCreateMyX",
                    "returnType": 2
                },
                {
                    "id": "a0e7f02b-3495-48de-abf7-ba8b8b36fa4f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjCreateMyY",
                    "help": "readObjCreateMyY()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjCreateMyY",
                    "returnType": 2
                },
                {
                    "id": "cce3682f-2f8c-425a-8f17-2085ad32cbb5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "objCreatesWaiting",
                    "help": "objCreatesWaiting()",
                    "hidden": false,
                    "kind": 12,
                    "name": "objCreatesWaiting",
                    "returnType": 2
                },
                {
                    "id": "368481e0-3ba3-49f5-9137-18548262b7e8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "myPrintf",
                    "help": "printf_external(some string)",
                    "hidden": false,
                    "kind": 12,
                    "name": "printf_external",
                    "returnType": 2
                },
                {
                    "id": "607daf61-ab86-4d24-a581-f665c18073c5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "sendGenMessageStr",
                    "help": "sendMessageStr(string msg, string val)",
                    "hidden": false,
                    "kind": 12,
                    "name": "sendMessageStr",
                    "returnType": 2
                },
                {
                    "id": "c727106c-64da-4fbe-a142-deb49105eb0d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "sendGenMessageReal",
                    "help": "sendMessageReal(string msg, real val)",
                    "hidden": false,
                    "kind": 12,
                    "name": "sendMessageReal",
                    "returnType": 2
                },
                {
                    "id": "82c1c3b6-00e9-4034-b8f8-dba054795237",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "createUser",
                    "help": "createUser(username, password)",
                    "hidden": false,
                    "kind": 12,
                    "name": "createUser",
                    "returnType": 2
                },
                {
                    "id": "75d3b425-c66f-48b1-ad57-49d7b851f0db",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "authenticate",
                    "help": "authenticate(username, password)",
                    "hidden": false,
                    "kind": 12,
                    "name": "authenticate",
                    "returnType": 2
                },
                {
                    "id": "12a2e390-e03d-472b-986e-27288736c304",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateFlag",
                    "help": "readObjUpdateFlag()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateFlag",
                    "returnType": 2
                },
                {
                    "id": "72dcd181-0e41-4919-8e61-6ac01e56dbef",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        2,
                        2
                    ],
                    "externalName": "statUpdateReal",
                    "help": "statUpdateReal(stat, real val, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "statUpdateReal",
                    "returnType": 2
                },
                {
                    "id": "3f35aecc-4432-4c56-b8ff-57d4d02e25ef",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        1,
                        2
                    ],
                    "externalName": "statUpdateStr",
                    "help": "statUpdateString(stat, string val, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "statUpdateString",
                    "returnType": 2
                },
                {
                    "id": "eff470ea-bfda-4d00-9b9d-3957f7d82bed",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        2
                    ],
                    "externalName": "otherPlayerStatUpdateStr",
                    "help": "otherPlayerStatUpdateStr(player name, stat, string val, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "otherPlayerStatUpdateStr",
                    "returnType": 2
                },
                {
                    "id": "5921bc05-87e9-4f7a-92d9-49aca00f7dda",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        2,
                        2
                    ],
                    "externalName": "otherPlayerStatUpdateReal",
                    "help": "otherPlayerStatUpdateReal(player name, stat, real val, flag)",
                    "hidden": false,
                    "kind": 12,
                    "name": "otherPlayerStatUpdateReal",
                    "returnType": 2
                },
                {
                    "id": "eaea08df-4c9d-4a7c-9cf6-ba101573476b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "initGrieferClient",
                    "help": " initGrieferClient()",
                    "hidden": false,
                    "kind": 12,
                    "name": "initGrieferClient",
                    "returnType": 2
                },
                {
                    "id": "e9a37fcb-ea31-463b-b7e8-27442324bb4a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readObjUpdateOidStr",
                    "help": "readObjUpdateOidStr()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readObjUpdateOidStr",
                    "returnType": 1
                },
                {
                    "id": "dc29a9e9-12f1-4acd-bbc8-9b216d269271",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "bigMessagesWaiting",
                    "help": "bigMessagesWaiting()",
                    "hidden": false,
                    "kind": 12,
                    "name": "bigMessagesWaiting",
                    "returnType": 2
                },
                {
                    "id": "3b9ca675-1bbd-4ab4-9199-9ef2ef75eb66",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "readBigMessage",
                    "help": "readBigMessage()",
                    "hidden": false,
                    "kind": 12,
                    "name": "readBigMessage",
                    "returnType": 1
                },
                {
                    "id": "e898cb6d-d7f3-4df7-8668-73d14e24b44f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "readBigValType",
                    "help": "readBigValType(val_num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "readBigValType",
                    "returnType": 1
                },
                {
                    "id": "326cc96a-78f2-41bb-bde2-9d1a54ddee5a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "readBigValStr",
                    "help": "readBigValStr(val_num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "readBigValStr",
                    "returnType": 1
                },
                {
                    "id": "b67ffc7d-f7c2-4d7d-b7d7-c7e182d6ac1b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "readBigValReal",
                    "help": "readBigValReal(val_num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "readBigValReal",
                    "returnType": 2
                },
                {
                    "id": "e1468499-1644-4c1b-b5e2-fd9a48f0f5a6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "sendBigMessageStr",
                    "help": "sendBigMessageStr(msg, string val1, string val2, string val3)",
                    "hidden": false,
                    "kind": 12,
                    "name": "sendBigMessageStr",
                    "returnType": 2
                },
                {
                    "id": "225647f0-6c0c-4afc-a90e-05bd8b473576",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        2,
                        2,
                        2
                    ],
                    "externalName": "sendBigMessageReal",
                    "help": "sendBigMessageReal(msg, real val1, real val2, real val3)",
                    "hidden": false,
                    "kind": 12,
                    "name": "sendBigMessageReal",
                    "returnType": 2
                },
                {
                    "id": "f5536091-099b-4eed-a6e6-5d797415bfde",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        2,
                        2
                    ],
                    "externalName": "sendBigMessageStrReal",
                    "help": "sendBigMessageStrReal(msg, string val1, real val2, real val3)",
                    "hidden": false,
                    "kind": 12,
                    "name": "sendBigMessageStrReal",
                    "returnType": 2
                },
                {
                    "id": "9f650456-12e6-4b0b-9b1b-85973a1ac35f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "setGppDebug",
                    "help": "setGppDebug(bool)",
                    "hidden": false,
                    "kind": 12,
                    "name": "setGppDebug",
                    "returnType": 2
                },
                {
                    "id": "61d205fa-3f9b-4197-9d34-756414875c69",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "hash_string",
                    "help": "hash_string(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "hash_string_gpp",
                    "returnType": 2
                },
                {
                    "id": "b6acfeb7-4ecb-4087-b4a6-51e4b57c1ec4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        2
                    ],
                    "externalName": "sendBigMessageStrReal2",
                    "help": "sendBigMessageStrReal2(str msg, str val1, str val2, real val3)",
                    "hidden": false,
                    "kind": 12,
                    "name": "sendBigMessageStrReal2",
                    "returnType": 2
                },
                {
                    "id": "0f95b715-ef9d-4ac6-9b1a-cc63ff9b2eb7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "keepAlive",
                    "help": "keepAlive()",
                    "hidden": false,
                    "kind": 12,
                    "name": "keepAlive",
                    "returnType": 2
                },
                {
                    "id": "d8dcc445-3e15-4ba3-8a5c-8a6e42ac9ee2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "isAlive",
                    "help": "isAlive()",
                    "hidden": false,
                    "kind": 12,
                    "name": "isAlive",
                    "returnType": 2
                },
                {
                    "id": "a8fb56d3-622d-4223-965c-f4637745a2ae",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "getExecPath",
                    "help": "",
                    "hidden": false,
                    "kind": 12,
                    "name": "getExecPath",
                    "returnType": 1
                },
                {
                    "id": "cf6aefc1-7b0d-4ca9-9a7d-365643c08621",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "updateGame",
                    "help": "updateGame(dir_newgame)",
                    "hidden": false,
                    "kind": 12,
                    "name": "updateGame",
                    "returnType": 2
                },
                {
                    "id": "f1b19997-cb7f-4668-926d-2645c59fbbe3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "moveFile",
                    "help": "moveFile(fpath1, fpath2)",
                    "hidden": false,
                    "kind": 12,
                    "name": "moveFile",
                    "returnType": 2
                },
                {
                    "id": "4b2bf5fe-2ec6-4bb8-b324-b2ba88410ffc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "closeConnection",
                    "help": "closeConection()",
                    "hidden": false,
                    "kind": 12,
                    "name": "closeConnection",
                    "returnType": 2
                },
                {
                    "id": "9466732a-1648-4137-8d49-13213a2b1a7e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "launchGame",
                    "help": "launchGame(game_path)",
                    "hidden": false,
                    "kind": 12,
                    "name": "launchGame",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "b9503706-a266-48a5-bfd3-3d990cc857e1",
                "695e0adb-8ccb-4654-9646-438c27dc6877",
                "de71e8d8-d896-4446-aee5-c9dc813e93d8",
                "25f7ea82-31b2-468d-b4dc-75d697a07fed",
                "d97e737a-b747-4db4-b675-bdfe71e8761c",
                "0d20ea20-a47e-4167-92ba-c35996d13e6d",
                "cbf8d07e-d3ca-4f98-8e8c-9e383c40d4fb",
                "76b55f4b-9861-4d9f-bf5b-79edb763c0c8",
                "951326a2-5d2f-4bd3-aaac-edcdb1ab1b7f",
                "c9f4a9e5-c6ba-475b-bcb1-33491f2ac539",
                "f1846e0e-e4cf-445b-bb0b-e74611e78f3f",
                "efe8d7ea-3e37-43e2-a999-ac641274ccf5",
                "67f4db42-b6b3-499e-af97-1dc39e104917",
                "413f250a-84a4-4d65-b96b-4e2bd6876a5a",
                "aa2754b0-0197-4cfd-8b4a-25ff76050f6c",
                "0b213ee1-e3e0-4e4b-87aa-dce4fcc7a531",
                "cf42e472-faca-4195-b449-926cc4d314fa",
                "7b559db6-eb2d-4e06-ab7e-3aa0040bc1d4",
                "10176eb6-5276-4166-8582-d654510c0b8f",
                "9a61bee3-388a-4bed-b007-c4a202b35521",
                "fdee866d-1e42-42e9-a3b5-d105bd9c827f",
                "cb6d9355-314a-443a-bee5-8f3ae5aa183c",
                "0edc3d3b-7069-4859-989b-a17067b180a8",
                "a6e5fee6-25db-44d5-b5d9-71ab9e9e2f00",
                "bb8a26c3-6d7c-4a01-83e8-f11c74271b55",
                "a0e7f02b-3495-48de-abf7-ba8b8b36fa4f",
                "cce3682f-2f8c-425a-8f17-2085ad32cbb5",
                "368481e0-3ba3-49f5-9137-18548262b7e8",
                "607daf61-ab86-4d24-a581-f665c18073c5",
                "c727106c-64da-4fbe-a142-deb49105eb0d",
                "82c1c3b6-00e9-4034-b8f8-dba054795237",
                "75d3b425-c66f-48b1-ad57-49d7b851f0db",
                "12a2e390-e03d-472b-986e-27288736c304",
                "72dcd181-0e41-4919-8e61-6ac01e56dbef",
                "3f35aecc-4432-4c56-b8ff-57d4d02e25ef",
                "eff470ea-bfda-4d00-9b9d-3957f7d82bed",
                "5921bc05-87e9-4f7a-92d9-49aca00f7dda",
                "eaea08df-4c9d-4a7c-9cf6-ba101573476b",
                "e9a37fcb-ea31-463b-b7e8-27442324bb4a",
                "dc29a9e9-12f1-4acd-bbc8-9b216d269271",
                "3b9ca675-1bbd-4ab4-9199-9ef2ef75eb66",
                "e898cb6d-d7f3-4df7-8668-73d14e24b44f",
                "326cc96a-78f2-41bb-bde2-9d1a54ddee5a",
                "b67ffc7d-f7c2-4d7d-b7d7-c7e182d6ac1b",
                "e1468499-1644-4c1b-b5e2-fd9a48f0f5a6",
                "225647f0-6c0c-4afc-a90e-05bd8b473576",
                "f5536091-099b-4eed-a6e6-5d797415bfde",
                "9f650456-12e6-4b0b-9b1b-85973a1ac35f",
                "61d205fa-3f9b-4197-9d34-756414875c69",
                "b6acfeb7-4ecb-4087-b4a6-51e4b57c1ec4",
                "0f95b715-ef9d-4ac6-9b1a-cc63ff9b2eb7",
                "d8dcc445-3e15-4ba3-8a5c-8a6e42ac9ee2",
                "a8fb56d3-622d-4223-965c-f4637745a2ae",
                "cf6aefc1-7b0d-4ca9-9a7d-365643c08621",
                "f1b19997-cb7f-4668-926d-2645c59fbbe3",
                "4b2bf5fe-2ec6-4bb8-b324-b2ba88410ffc",
                "9466732a-1648-4137-8d49-13213a2b1a7e"
            ],
            "origname": "extensions\\GriefPlusPlus.dll",
            "uncompress": false
        },
        {
            "id": "be5d5ea9-fa5b-4c3c-a52e-2f8d7615111f",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "msvcp120.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\msvcp120.dll",
            "uncompress": false
        },
        {
            "id": "7d302a77-df57-4681-9ef2-575b1824c803",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "msvcr120.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\msvcr120.dll",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosplistinject": "",
    "license": "Free to use, also for commercial games.",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "version": "1.0.0"
}