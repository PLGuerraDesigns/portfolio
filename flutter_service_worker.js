'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"manifest.json": "b8bb80c94c29e93bf4dec35ebffe4a15",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"index.html": "52fa2617a135bf027e4b8d9f6b1d988b",
"/": "52fa2617a135bf027e4b8d9f6b1d988b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "5b422a4d8bb78e5abc3d8f7501316d42",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "f2163b9d4e6f1ea52063f498c8878bb9",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/assets/json/projects.json": "8d8bacf38e8e2eb60677589c3880cf12",
"assets/assets/json/professional_experience.json": "8f5e026ee0a20f9f5a898b0bbddd6890",
"assets/assets/images/home/uark_logo.webp": "25f9bd41af589eb1cbf4f252e44d95b5",
"assets/assets/images/home/professional.webp": "75f453e38f3c03d23bc8a6706dd2c654",
"assets/assets/images/home/personal.webp": "914ff356f29394fb639162da9bb1793f",
"assets/assets/images/home/profile_dark.webp": "25190927982f0a87f28d4ea78735a886",
"assets/assets/images/home/gmu_logo.webp": "451e0b4b14a38a7fd35d157c04ae527d",
"assets/assets/images/professional/am3_lab/image_3.webp": "09c17194110621a35af43c4807498d2d",
"assets/assets/images/professional/am3_lab/image_6.webp": "8d9fca78dec0c9e3c9408e0c2d6fa2e5",
"assets/assets/images/professional/am3_lab/logo.webp": "25f9bd41af589eb1cbf4f252e44d95b5",
"assets/assets/images/professional/am3_lab/video_9.mp4": "ef94275f2b159205aa4cd4c8be20ae40",
"assets/assets/images/professional/am3_lab/video_thumbnail_9.webp": "23eef52b27241fcbf4c2fa23de785458",
"assets/assets/images/professional/am3_lab/image_5.webp": "d823e20e44c8309c496a45fa6007ca73",
"assets/assets/images/professional/am3_lab/image_4.webp": "de192cf487e6d5914fdbb956a25e4850",
"assets/assets/images/professional/am3_lab/image_1.webp": "9e389436fad924ed54da2ea3c3977485",
"assets/assets/images/professional/am3_lab/image_2.webp": "18b83ae06d1fd24216df4d99e79593d9",
"assets/assets/images/professional/am3_lab/thumbnail.webp": "44678577e378d06b5211868126c7b771",
"assets/assets/images/professional/am3_lab/image_7.webp": "f69985eeff205c2d0f115d72aad5365f",
"assets/assets/images/professional/ambots/image_3.webp": "6eb28e5a259981356f0426b80b4d0bc1",
"assets/assets/images/professional/ambots/image_8.webp": "98f9ed55853595bd40a5b69d26e67beb",
"assets/assets/images/professional/ambots/image_15.webp": "b46455b4ad15f98d7b417c7482861c69",
"assets/assets/images/professional/ambots/image_6.webp": "9b9688baa7bdc6bccdcd30abf5f46ce0",
"assets/assets/images/professional/ambots/image_12.webp": "95c14efb3788f82477e093a4ea9c5201",
"assets/assets/images/professional/ambots/logo.webp": "c8329ace9b11d66a240aca1fe05e0aca",
"assets/assets/images/professional/ambots/image_17.webp": "abe857e303c4fa08aeb68adb9151de26",
"assets/assets/images/professional/ambots/image_14.webp": "64a7cf953ecbb8c3652a30508e990b37",
"assets/assets/images/professional/ambots/image_9.webp": "027459b37f3311ba5ea69ac3a7bd728e",
"assets/assets/images/professional/ambots/image_10.webp": "11ee2f4194bafdee4be8837ba9c66b45",
"assets/assets/images/professional/ambots/video_10.mp4": "ddee026980cc5b014cc8835d01867aa3",
"assets/assets/images/professional/ambots/image_11.webp": "532bfc17e14d8a8be295d848c113f108",
"assets/assets/images/professional/ambots/image_5.webp": "db72040859b4086020511ea651056638",
"assets/assets/images/professional/ambots/image_4.webp": "5ec14847f04090ee34ea030c76fb2c86",
"assets/assets/images/professional/ambots/image_1.webp": "093698ddc649b6e703c57bafa5a29568",
"assets/assets/images/professional/ambots/image_13.webp": "fbe56c134de3ec2193da51d18cdde1e2",
"assets/assets/images/professional/ambots/video_thumbnail_10.webp": "a0d54d4bd4b4656b178dba2f86444739",
"assets/assets/images/professional/ambots/image_2.webp": "b1930f5c7ddc86c71225603f3270f9c3",
"assets/assets/images/professional/ambots/image_16.webp": "c55aaaae49ba1b09629ba27c8b204db8",
"assets/assets/images/professional/ambots/thumbnail.webp": "2736e4e06b7b9d1848e058a097bb971f",
"assets/assets/images/professional/ambots/image_7.webp": "77c8a036b038ca9bd0e3a90128ea7803",
"assets/assets/images/professional/atlantic_insurance/logo.webp": "6264dd2adfe428a89e462a33827993b6",
"assets/assets/images/professional/atlantic_insurance/image_1.webp": "006f64b57885cd6b6640e8bd46efced8",
"assets/assets/images/professional/atlantic_insurance/image_2.webp": "e88e4c278982468e762763d023ea4d34",
"assets/assets/images/professional/atlantic_insurance/thumbnail.webp": "75f453e38f3c03d23bc8a6706dd2c654",
"assets/assets/images/personal/switch_speaker/image_3.webp": "662f8915c6d0052d2336a6c43a4a4a3c",
"assets/assets/images/personal/switch_speaker/image_6.webp": "74e89365e3cf1c9bf0f9294bdbf739a7",
"assets/assets/images/personal/switch_speaker/image_5.webp": "b5ffedcebbe141fdcdfad2d1617492e2",
"assets/assets/images/personal/switch_speaker/image_4.webp": "127723a6c72e5cd4391ca93706f46ac7",
"assets/assets/images/personal/switch_speaker/image_1.webp": "4a48e9c9125c63a1d7eaf4fd060566b0",
"assets/assets/images/personal/switch_speaker/image_2.webp": "586a576c49ca7db06c74ab6f88a371fd",
"assets/assets/images/personal/switch_speaker/thumbnail.webp": "fd990eded0669361e4b5b7ab0cf8cbcb",
"assets/assets/images/personal/flutter_resume_builder/thumbnail.webp": "d59439af0337157c678ad71ed282eba5",
"assets/assets/images/personal/macro_pad/image_1.webp": "386b6cf5bbf6192df67cd4f8c4bcff3f",
"assets/assets/images/personal/macro_pad/image_2.webp": "59e976feab75065b5cf34fcb8fdb1dba",
"assets/assets/images/personal/macro_pad/thumbnail.webp": "0c102c2e715e44ee30bc29e7900abc2e",
"assets/assets/images/personal/swe_632_lottery/image_3.webp": "e28db7c80fb701f77ed7d81cccfdadda",
"assets/assets/images/personal/swe_632_lottery/image_6.webp": "187b2d3419c33340f4d1e670dc1ba2f3",
"assets/assets/images/personal/swe_632_lottery/image_5.webp": "ab16d8a69f5fb91cafb72054ddda407e",
"assets/assets/images/personal/swe_632_lottery/image_4.webp": "0a3fcead7fdc3cf3ef42a3d89e3d5856",
"assets/assets/images/personal/swe_632_lottery/image_1.webp": "3a566cf46bdf2952719342469efff2b5",
"assets/assets/images/personal/swe_632_lottery/image_2.webp": "3d3e6ebde15fef95fbe29520cdc51f87",
"assets/assets/images/personal/swe_632_lottery/thumbnail.webp": "74088b3c30ae1a7482098649e5482122",
"assets/assets/images/personal/swe_632_lottery/image_7.webp": "c051ab8f0ec2976c15a20b756bb37414",
"assets/assets/images/personal/handroid/image_3.webp": "154044bae286ed39f61471d4c77e3971",
"assets/assets/images/personal/handroid/image_8.webp": "d173d95d571850e68f2c1e8155b70016",
"assets/assets/images/personal/handroid/image_6.webp": "2bfcd0aaf6312f505b216f022fd9e51a",
"assets/assets/images/personal/handroid/image_12.webp": "163afd71d65f200187f6fe529cda01f5",
"assets/assets/images/personal/handroid/image_9.webp": "ac5068603b9f2ec076ace7a6d074de25",
"assets/assets/images/personal/handroid/image_10.webp": "0d8252cc1cddb69095d85c3743e3f5a4",
"assets/assets/images/personal/handroid/image_11.webp": "fc981649ba39936425cee56426b5035b",
"assets/assets/images/personal/handroid/image_5.webp": "af4adb6e08eafa6df71b8af36e78c072",
"assets/assets/images/personal/handroid/image_4.webp": "55cd57a69f98a6655a3388180557557d",
"assets/assets/images/personal/handroid/video_1.mp4": "4b87d0241051f1935e669afba8607fcd",
"assets/assets/images/personal/handroid/image_1.webp": "8da6deaf38f66e1b62ad85c816388396",
"assets/assets/images/personal/handroid/image_13.webp": "f1c78fb1972e6a6dae07c496b1c580ad",
"assets/assets/images/personal/handroid/image_2.webp": "f9107c48be9c56c4807b8fdaee72d5fd",
"assets/assets/images/personal/handroid/thumbnail.webp": "a42d100ed952e4bbc1670fe071545141",
"assets/assets/images/personal/handroid/video_thumbnail_1.webp": "dfa467c3ce4def0b21cc0f24a9c55655",
"assets/assets/images/personal/handroid/image_7.webp": "2012f8f8b459dd11a79e7a75e9e6e86b",
"assets/assets/images/personal/safedrive_mk1/image_3.webp": "69fdd61198c46908d39a67db7db4fcb4",
"assets/assets/images/personal/safedrive_mk1/image_8.webp": "0fb60f06cb131e846bc61923db798f77",
"assets/assets/images/personal/safedrive_mk1/image_6.webp": "4a0cbd875844637c89b12e607550002d",
"assets/assets/images/personal/safedrive_mk1/video_2.mp4": "cee454902c23d32dcef8b06fcdb82892",
"assets/assets/images/personal/safedrive_mk1/image_9.webp": "63ae6b3ff45a6395ca2865a87cd91298",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_3.webp": "800555de16d2caeebfee90c412692568",
"assets/assets/images/personal/safedrive_mk1/image_5.webp": "9677369482a5f5b8d9d348076f96130c",
"assets/assets/images/personal/safedrive_mk1/image_4.webp": "e0abe905a692fcbc89e441743fb0d1ab",
"assets/assets/images/personal/safedrive_mk1/video_1.mp4": "94d8b6e747c6ed60489368aeac680eea",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_2.webp": "4153b93ae66bd24226c9b948cb0ef341",
"assets/assets/images/personal/safedrive_mk1/video_4.mp4": "61e565fd54f84f32bcb276f347cbf69c",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_4.webp": "440954b7b8de4d5d4f8866b5418fdce3",
"assets/assets/images/personal/safedrive_mk1/image_1.webp": "73f066596a9ccbd05d1946e5381f5f0c",
"assets/assets/images/personal/safedrive_mk1/image_2.webp": "3addb3c6f101cad8a77d18a6e4c25d1f",
"assets/assets/images/personal/safedrive_mk1/video_3.mp4": "4b6a4a6ce34ca4f8449a3b404c2c2f60",
"assets/assets/images/personal/safedrive_mk1/thumbnail.webp": "9f15a8a4c95489bd1ca3207f3f801be1",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_1.webp": "4aabc74169979f5cfcc48838c34ada4e",
"assets/assets/images/personal/safedrive_mk1/image_7.webp": "a502780f51b78b7883e832456b341891",
"assets/assets/images/personal/f1_sim_engineer/video_1.mp4": "c0c2de57b37041fcdd5a6a08e6d19495",
"assets/assets/images/personal/f1_sim_engineer/thumbnail.webp": "ecf9cce4941c1c959caed65a1286d995",
"assets/assets/images/personal/f1_sim_engineer/video_thumbnail_1.webp": "4ac72d0b57d2c8d84b392754cb69e5df",
"assets/assets/images/personal/xbox_head_tracking/image_3.webp": "fbf456648dd0126bb2cdb59944b84847",
"assets/assets/images/personal/xbox_head_tracking/video_2.mp4": "837e370232d5418620d789aba1baf8b0",
"assets/assets/images/personal/xbox_head_tracking/video_thumbnail_3.webp": "e46148081ef5167e6fed2a0caf0df97d",
"assets/assets/images/personal/xbox_head_tracking/image_5.webp": "1dd9ad22280a30b8ddbbf8dea74b8b7e",
"assets/assets/images/personal/xbox_head_tracking/image_4.webp": "fd7f389cc75bf0ec60fcd42e74b41708",
"assets/assets/images/personal/xbox_head_tracking/video_1.mp4": "f21365d9503174f30d115cbfb573219a",
"assets/assets/images/personal/xbox_head_tracking/video_thumbnail_2.webp": "427afd50c9d682c91bc5f6e88e9d04f7",
"assets/assets/images/personal/xbox_head_tracking/image_1.webp": "7ceff80a6421ac372ce20ba2a1e52392",
"assets/assets/images/personal/xbox_head_tracking/image_2.webp": "9c7f1d59f8e0e0190731416a7de40ebf",
"assets/assets/images/personal/xbox_head_tracking/video_3.mp4": "cb038b15c811fb00afee760a17a152cd",
"assets/assets/images/personal/xbox_head_tracking/thumbnail.webp": "e9d43379c4f05d1bc6692d0db2066f08",
"assets/assets/images/personal/xbox_head_tracking/video_thumbnail_1.webp": "652dc63f9e155427d39e1c094f3ee104",
"assets/assets/images/personal/led_wall_decor/image_1.webp": "fe6263f10be68ab4340c95eb084668d9",
"assets/assets/images/personal/led_wall_decor/image_2.webp": "e32ca6b2dd5e78ef7fd119873a08f41e",
"assets/assets/images/personal/led_wall_decor/thumbnail.webp": "55fc9ad122adb7ed0df8f726a8eb2a07",
"assets/assets/images/personal/amg_gt3_wheel/image_3.webp": "5be05328ec1af6811ad752f4344a1aff",
"assets/assets/images/personal/amg_gt3_wheel/image_8.webp": "66ae505d6c1bfbb8fbbf9f299a3a1bca",
"assets/assets/images/personal/amg_gt3_wheel/image_6.webp": "1f5c2950786288a4f1d0a0ea0c0d2b57",
"assets/assets/images/personal/amg_gt3_wheel/image_12.webp": "2afbb0f0128393d27fa49877fa86485e",
"assets/assets/images/personal/amg_gt3_wheel/image_14.webp": "f6e257dc01133049da91588b7c6af846",
"assets/assets/images/personal/amg_gt3_wheel/video_2.mp4": "e7fcc06502cfe260e9ad61bc8e0aa92d",
"assets/assets/images/personal/amg_gt3_wheel/image_9.webp": "9c10f21f42cdfc3bc9b51b3906740b40",
"assets/assets/images/personal/amg_gt3_wheel/image_10.webp": "f75dca00b387972df82701da0381aac6",
"assets/assets/images/personal/amg_gt3_wheel/image_11.webp": "de830d4a8be5f057e46f849dbb523f9e",
"assets/assets/images/personal/amg_gt3_wheel/image_5.webp": "cef1611edc1e7b2b71826ea6fc511da9",
"assets/assets/images/personal/amg_gt3_wheel/image_4.webp": "8e756df9e589d735c1870867eedc51e0",
"assets/assets/images/personal/amg_gt3_wheel/video_1.mp4": "eb5a534f0907243134d9cbecbaa1ce5c",
"assets/assets/images/personal/amg_gt3_wheel/video_thumbnail_2.webp": "6a81cc37aedb94d4fc15f3aec29f4cc8",
"assets/assets/images/personal/amg_gt3_wheel/image_1.webp": "b83adf6b368c2f019a204c39c8bb681f",
"assets/assets/images/personal/amg_gt3_wheel/image_13.webp": "325215c341d6330232e2f724861696a3",
"assets/assets/images/personal/amg_gt3_wheel/image_2.webp": "af133aa2db21e0f322c8c6d7caf4a1d2",
"assets/assets/images/personal/amg_gt3_wheel/thumbnail.webp": "0228a7a1edd110818e04a415caa5dfbb",
"assets/assets/images/personal/amg_gt3_wheel/video_thumbnail_1.webp": "01de86fff8fb2387ba04868e8f48eed5",
"assets/assets/images/personal/amg_gt3_wheel/image_7.webp": "1f810d6f858c04dd1377499cf813a175",
"assets/assets/images/personal/android_calculator/video_1.mp4": "73d5e457e796629991cc0854dd3d0030",
"assets/assets/images/personal/android_calculator/image_1.webp": "3ed3c5cf7bf8ce27bb78a368646d651e",
"assets/assets/images/personal/android_calculator/thumbnail.webp": "e99e28f7c6c51b2e7a45f5616cff9c03",
"assets/assets/images/personal/android_calculator/video_thumbnail_1.webp": "8c1073d0b94a2ad4dae8eae919883785",
"assets/assets/images/personal/project_lemans/image_3.webp": "13a892cc4aa2b307f4c6df720dca0f9a",
"assets/assets/images/personal/project_lemans/image_8.webp": "63381159b54656f0d4994d50c9d9f055",
"assets/assets/images/personal/project_lemans/image_15.webp": "c6c95e8e6b570c136dad3ae529741c46",
"assets/assets/images/personal/project_lemans/image_6.webp": "528f13c870cdc761649b5f2082cf9fa5",
"assets/assets/images/personal/project_lemans/image_12.webp": "b07b8dd82aee1e6e5a435572c36e1566",
"assets/assets/images/personal/project_lemans/image_17.webp": "4b69ccbdee163c7229e7bd3915262ec5",
"assets/assets/images/personal/project_lemans/image_14.webp": "69144935516fc9b765e456d81347cbde",
"assets/assets/images/personal/project_lemans/image_25.webp": "fb655ebc10799fa04a9f3d68779ea17c",
"assets/assets/images/personal/project_lemans/image_26.webp": "4dbda29918043c637b9b52b8d8abe8db",
"assets/assets/images/personal/project_lemans/image_9.webp": "ca65050b9e6b19798dc0f86354a0927b",
"assets/assets/images/personal/project_lemans/image_10.webp": "815248f92407c8a32e8c63bdbbd422de",
"assets/assets/images/personal/project_lemans/image_11.webp": "8203ed879361acd6db6c3262722432e8",
"assets/assets/images/personal/project_lemans/image_5.webp": "417f56000970c04ba65a7042e41a4a19",
"assets/assets/images/personal/project_lemans/image_4.webp": "c2beaeb1e27fdb37d918f705e53cda40",
"assets/assets/images/personal/project_lemans/image_19.webp": "afe2804e304c48b38431708e2f567396",
"assets/assets/images/personal/project_lemans/image_22.webp": "a212ed0bc2b7d476d3ffb273f2a79bdd",
"assets/assets/images/personal/project_lemans/video_1.mp4": "74aefefed85314d9ca4953b1bcab457e",
"assets/assets/images/personal/project_lemans/image_24.webp": "b1ff6f7e3f963796609b52edaecb3a52",
"assets/assets/images/personal/project_lemans/image_1.webp": "d416383bb0435a25b789e407b454bd0d",
"assets/assets/images/personal/project_lemans/image_13.webp": "442f0600725ff7bddf022ee705a51326",
"assets/assets/images/personal/project_lemans/image_2.webp": "fc8bc5cf5b811a91ea7c6717af7952f8",
"assets/assets/images/personal/project_lemans/image_23.webp": "43f78fb93f9a1c0097d971377b467834",
"assets/assets/images/personal/project_lemans/image_18.webp": "7c52b95a43fc56fa7a8f7f73f904582f",
"assets/assets/images/personal/project_lemans/image_16.webp": "a5520fafae0b8f89a01af56b313fe50f",
"assets/assets/images/personal/project_lemans/thumbnail.webp": "1811cdf183a247756f2f3b557a942aec",
"assets/assets/images/personal/project_lemans/video_thumbnail_1.webp": "d952d24982ccb8cfd4f806aebf71b2c8",
"assets/assets/images/personal/project_lemans/image_21.webp": "911da94934df48f054fc95185269b56c",
"assets/assets/images/personal/project_lemans/image_7.webp": "d69464375c381f1efb473602d4abffc0",
"assets/assets/images/personal/project_lemans/image_20.webp": "e27342802f1da5c85d5bccc64f21f22d",
"assets/assets/images/personal/amg_inspired_mobile_sim_wheel/image_3.webp": "181856fe92b906c226895f8ac14257da",
"assets/assets/images/personal/amg_inspired_mobile_sim_wheel/image_1.webp": "e490883b3595bed7fd1a32d1092cb121",
"assets/assets/images/personal/amg_inspired_mobile_sim_wheel/image_2.webp": "6326f536b15d118c56f86eed3f3c43d8",
"assets/assets/images/personal/amg_inspired_mobile_sim_wheel/thumbnail.webp": "8fb03511d3d343789c5f131f4cb85027",
"assets/assets/images/personal/blokus/thumbnail.webp": "73b4bd85f614eb4c5aaae432bc917fd5",
"assets/assets/images/personal/apple_charging_station/image_3.webp": "8da6e809bdcab19c396ddf9927be09e3",
"assets/assets/images/personal/apple_charging_station/image_6.webp": "d9da63ec8089a19043ae974644113dab",
"assets/assets/images/personal/apple_charging_station/image_5.webp": "8731f313fba125110194440601ee04da",
"assets/assets/images/personal/apple_charging_station/image_4.webp": "241cc9875e915c7de8640cfcab981b8a",
"assets/assets/images/personal/apple_charging_station/image_1.webp": "02e7da8a87d8a2a4981a646986852af9",
"assets/assets/images/personal/apple_charging_station/image_2.webp": "8c91c54980c2385cfa536ec0153c6a97",
"assets/assets/images/personal/apple_charging_station/thumbnail.webp": "046c1ffab300af72fa0c782b612c0953",
"assets/assets/images/personal/apple_charging_station/image_7.webp": "f9a3a0efa1f1d8784edb7759a72c4095",
"assets/assets/images/icons/github.webp": "a06267e93376455b5d4776259f39b6e7",
"assets/assets/images/icons/linkedin.webp": "88999fba7abab5c69e3cdf2421e64fc7",
"assets/assets/images/icons/resume_builder.webp": "8d2c742ae542fe59e622e4e806a36263",
"assets/assets/images/icons/thingiverse.webp": "86a7fd7479011fd98ba556cfc3d6df44",
"assets/AssetManifest.bin.json": "a0321929f04a08a84ec449664b8869ea",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/NOTICES": "3b2b3564cd5d86594fb376a781a2a0ad",
"assets/fonts/MaterialIcons-Regular.otf": "564b1988265ef4adfd6491151c3f10ed",
"assets/AssetManifest.json": "3958166ca981cf9e90ad7e942ae85292",
"main.dart.js": "3073e87138321b48e1f42183c69153b4",
"favicon.png": "baf227a07cf56a61f1a579027a3ab7ed",
"version.json": "78126ba0797a7bf6931c13129afddeee",
"icons/Icon-maskable-192.png": "8403e61d84a145213b51a74f6a04f488",
"icons/Icon-192.png": "8403e61d84a145213b51a74f6a04f488",
"icons/Icon-512.png": "c6e9e9241cba806f198521f77ebf1446",
"icons/Icon-maskable-512.png": "c6e9e9241cba806f198521f77ebf1446"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
