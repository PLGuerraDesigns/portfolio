'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "08a6a62da21f8aff2c8ee430d77adf97",
"assets/assets/images/home/uark_logo.webp": "25f9bd41af589eb1cbf4f252e44d95b5",
"assets/assets/images/home/professional.webp": "c90aead7eec0a83a4b9469d13a828218",
"assets/assets/images/home/personal.webp": "35811fd5a69326a91ca2f63f641de32b",
"assets/assets/images/home/sjc_logo.webp": "951d32323036d75d05dc6ed34d1d21cd",
"assets/assets/images/home/gmu_logo.webp": "76e73d9e90677e4d2ae16b34821ec21e",
"assets/assets/images/home/profile_dark.webp": "25190927982f0a87f28d4ea78735a886",
"assets/assets/images/icons/monogram.webp": "7874bd3f90060ef5fd86ea1af2b1dcd9",
"assets/assets/images/icons/youtube.webp": "5b1469f098f45edf42de4a69021d1fdc",
"assets/assets/images/icons/linkedin.webp": "88999fba7abab5c69e3cdf2421e64fc7",
"assets/assets/images/icons/github.webp": "a06267e93376455b5d4776259f39b6e7",
"assets/assets/images/icons/thingiverse.webp": "86a7fd7479011fd98ba556cfc3d6df44",
"assets/assets/images/personal/blokus/thumbnail.webp": "39d01faff2486d6b6f216e8038dff0bc",
"assets/assets/images/personal/android_calculator/video_1.mp4": "73d5e457e796629991cc0854dd3d0030",
"assets/assets/images/personal/android_calculator/thumbnail.webp": "e99e28f7c6c51b2e7a45f5616cff9c03",
"assets/assets/images/personal/android_calculator/image_1.webp": "3ed3c5cf7bf8ce27bb78a368646d651e",
"assets/assets/images/personal/android_calculator/video_thumbnail_1.webp": "7f03cfa60d8937c4017194b66b2a96a2",
"assets/assets/images/personal/project_lemans/video_1.mp4": "74aefefed85314d9ca4953b1bcab457e",
"assets/assets/images/personal/project_lemans/thumbnail.webp": "1811cdf183a247756f2f3b557a942aec",
"assets/assets/images/personal/project_lemans/image_1.webp": "d416383bb0435a25b789e407b454bd0d",
"assets/assets/images/personal/project_lemans/image_13.webp": "446160e084e31fb131c308c06a68fa4f",
"assets/assets/images/personal/project_lemans/image_3.webp": "82da9f7c14a02a41e821815edcb6b343",
"assets/assets/images/personal/project_lemans/image_4.webp": "61845e26e04c068483722d5642f03be6",
"assets/assets/images/personal/project_lemans/image_5.webp": "6d7899636b5c6f42bb40f2d20b95e1d4",
"assets/assets/images/personal/project_lemans/image_11.webp": "8668e7025533e68eefd7a5bd64aa4da0",
"assets/assets/images/personal/project_lemans/image_22.webp": "a212ed0bc2b7d476d3ffb273f2a79bdd",
"assets/assets/images/personal/project_lemans/image_24.webp": "b1ff6f7e3f963796609b52edaecb3a52",
"assets/assets/images/personal/project_lemans/image_20.webp": "e27342802f1da5c85d5bccc64f21f22d",
"assets/assets/images/personal/project_lemans/image_12.webp": "9ff652a5f3769dee72b33a6ef2161d50",
"assets/assets/images/personal/project_lemans/image_10.webp": "cc3fa67d208b8b969749a4a78b07421b",
"assets/assets/images/personal/project_lemans/image_9.webp": "a719f89dad245a66f380377fdb2adee6",
"assets/assets/images/personal/project_lemans/image_17.webp": "4b69ccbdee163c7229e7bd3915262ec5",
"assets/assets/images/personal/project_lemans/image_21.webp": "911da94934df48f054fc95185269b56c",
"assets/assets/images/personal/project_lemans/image_25.webp": "fb655ebc10799fa04a9f3d68779ea17c",
"assets/assets/images/personal/project_lemans/image_14.webp": "69144935516fc9b765e456d81347cbde",
"assets/assets/images/personal/project_lemans/video_thumbnail_1.webp": "819d11210e38bee615e2bbff5ad78e52",
"assets/assets/images/personal/project_lemans/image_23.webp": "43f78fb93f9a1c0097d971377b467834",
"assets/assets/images/personal/project_lemans/image_6.webp": "528f13c870cdc761649b5f2082cf9fa5",
"assets/assets/images/personal/project_lemans/image_16.webp": "a5520fafae0b8f89a01af56b313fe50f",
"assets/assets/images/personal/project_lemans/image_8.webp": "63381159b54656f0d4994d50c9d9f055",
"assets/assets/images/personal/project_lemans/image_18.webp": "7c52b95a43fc56fa7a8f7f73f904582f",
"assets/assets/images/personal/project_lemans/image_15.webp": "c6c95e8e6b570c136dad3ae529741c46",
"assets/assets/images/personal/project_lemans/image_2.webp": "fc8bc5cf5b811a91ea7c6717af7952f8",
"assets/assets/images/personal/project_lemans/image_26.webp": "4dbda29918043c637b9b52b8d8abe8db",
"assets/assets/images/personal/project_lemans/image_19.webp": "afe2804e304c48b38431708e2f567396",
"assets/assets/images/personal/amg_gt3_wheel/video_1.mp4": "eb5a534f0907243134d9cbecbaa1ce5c",
"assets/assets/images/personal/amg_gt3_wheel/thumbnail.webp": "0228a7a1edd110818e04a415caa5dfbb",
"assets/assets/images/personal/amg_gt3_wheel/image_1.webp": "b83adf6b368c2f019a204c39c8bb681f",
"assets/assets/images/personal/amg_gt3_wheel/image_13.webp": "04c3640763f71d0dfb12d941deb7ee80",
"assets/assets/images/personal/amg_gt3_wheel/image_3.webp": "5be05328ec1af6811ad752f4344a1aff",
"assets/assets/images/personal/amg_gt3_wheel/video_thumbnail_2.webp": "ddd8f6cb5c454f32c39b98864d807873",
"assets/assets/images/personal/amg_gt3_wheel/image_5.webp": "cef1611edc1e7b2b71826ea6fc511da9",
"assets/assets/images/personal/amg_gt3_wheel/image_11.webp": "de830d4a8be5f057e46f849dbb523f9e",
"assets/assets/images/personal/amg_gt3_wheel/image_12.webp": "2afbb0f0128393d27fa49877fa86485e",
"assets/assets/images/personal/amg_gt3_wheel/image_10.webp": "f75dca00b387972df82701da0381aac6",
"assets/assets/images/personal/amg_gt3_wheel/image_9.webp": "9c10f21f42cdfc3bc9b51b3906740b40",
"assets/assets/images/personal/amg_gt3_wheel/image_17.webp": "3337c3e32a5372530b17fad21e608edd",
"assets/assets/images/personal/amg_gt3_wheel/image_14.webp": "f6e257dc01133049da91588b7c6af846",
"assets/assets/images/personal/amg_gt3_wheel/image_7.webp": "1f810d6f858c04dd1377499cf813a175",
"assets/assets/images/personal/amg_gt3_wheel/video_thumbnail_1.webp": "79337eb18d521b01ded98f2dd65bef58",
"assets/assets/images/personal/amg_gt3_wheel/image_6.webp": "1f5c2950786288a4f1d0a0ea0c0d2b57",
"assets/assets/images/personal/amg_gt3_wheel/image_16.webp": "35811fd5a69326a91ca2f63f641de32b",
"assets/assets/images/personal/amg_gt3_wheel/image_8.webp": "66ae505d6c1bfbb8fbbf9f299a3a1bca",
"assets/assets/images/personal/amg_gt3_wheel/image_18.webp": "4d6e17e16b802d2d2bb8f912266d9e4d",
"assets/assets/images/personal/amg_gt3_wheel/image_15.webp": "de229e7d8e6de7bfec583ee83ccc545a",
"assets/assets/images/personal/amg_gt3_wheel/video_2.mp4": "e7fcc06502cfe260e9ad61bc8e0aa92d",
"assets/assets/images/personal/amg_gt3_wheel/image_2.webp": "ec33af04c16cdf5f0a71a4d07bf9b6bd",
"assets/assets/images/personal/amg_gt3_wheel/image_19.webp": "fea68cc54b7956a2634d5065eccb93e5",
"assets/assets/images/personal/switch_speaker/thumbnail.webp": "fd990eded0669361e4b5b7ab0cf8cbcb",
"assets/assets/images/personal/switch_speaker/image_1.webp": "4a48e9c9125c63a1d7eaf4fd060566b0",
"assets/assets/images/personal/switch_speaker/image_3.webp": "662f8915c6d0052d2336a6c43a4a4a3c",
"assets/assets/images/personal/switch_speaker/image_4.webp": "127723a6c72e5cd4391ca93706f46ac7",
"assets/assets/images/personal/switch_speaker/image_5.webp": "b5ffedcebbe141fdcdfad2d1617492e2",
"assets/assets/images/personal/switch_speaker/image_7.webp": "4ee1ca61638e6b1d8edbbf429cfc36be",
"assets/assets/images/personal/switch_speaker/image_6.webp": "74e89365e3cf1c9bf0f9294bdbf739a7",
"assets/assets/images/personal/switch_speaker/image_8.webp": "20339767c7b557d415b4bcc20b17e7c6",
"assets/assets/images/personal/switch_speaker/image_2.webp": "586a576c49ca7db06c74ab6f88a371fd",
"assets/assets/images/personal/swe_632_lottery/thumbnail.webp": "55da9e84dcb87058100507e2078c2181",
"assets/assets/images/personal/swe_632_lottery/image_1.webp": "376d916b405022ec99561e71e161898d",
"assets/assets/images/personal/swe_632_lottery/image_3.webp": "22c9092b313a5159d9e35646d2394d8f",
"assets/assets/images/personal/swe_632_lottery/image_4.webp": "395e1404a0876ccc1b845ac4ee11facd",
"assets/assets/images/personal/swe_632_lottery/image_5.webp": "6a343ab7915f203ac6dfa26450ad2e36",
"assets/assets/images/personal/swe_632_lottery/image_7.webp": "9201ad6e89ead344f3590b0e2bacd35d",
"assets/assets/images/personal/swe_632_lottery/image_6.webp": "1064be46564706235ea47f8ff1315961",
"assets/assets/images/personal/swe_632_lottery/image_2.webp": "1f31fc82c0d791948735665d04d0c355",
"assets/assets/images/personal/mobile_sim_wheel/thumbnail.webp": "2b509b4880ffea1893a00aa7745c2209",
"assets/assets/images/personal/mobile_sim_wheel/image_1.webp": "e4752467201c1715889f9b74fab5f425",
"assets/assets/images/personal/mobile_sim_wheel/image_3.webp": "48428d6f9614612bda32aac570cc7e1f",
"assets/assets/images/personal/mobile_sim_wheel/image_4.webp": "b17d4130244c65505b60dfc6fb247dc0",
"assets/assets/images/personal/mobile_sim_wheel/image_5.webp": "434994016e42ac7ebfda7abb64652fb7",
"assets/assets/images/personal/mobile_sim_wheel/image_7.webp": "0fe94229e1d1c813c812b92ab4604309",
"assets/assets/images/personal/mobile_sim_wheel/image_6.webp": "07922731647082b505d0d5cabbefe79f",
"assets/assets/images/personal/mobile_sim_wheel/image_8.webp": "49351ecde02dc8bd655576a42bf1b741",
"assets/assets/images/personal/mobile_sim_wheel/image_2.webp": "7b41c13342e2f098794d0f7ebf4ab6e3",
"assets/assets/images/personal/f1_sim_engineer/video_1.mp4": "c0c2de57b37041fcdd5a6a08e6d19495",
"assets/assets/images/personal/f1_sim_engineer/thumbnail.webp": "ecf9cce4941c1c959caed65a1286d995",
"assets/assets/images/personal/f1_sim_engineer/video_thumbnail_1.webp": "234a7708f269f0d1492614a7ffb3b235",
"assets/assets/images/personal/handroid/video_1.mp4": "4b87d0241051f1935e669afba8607fcd",
"assets/assets/images/personal/handroid/thumbnail.webp": "a42d100ed952e4bbc1670fe071545141",
"assets/assets/images/personal/handroid/image_1.webp": "a9a6f4803ac5c08a1c675f3b9e7c989e",
"assets/assets/images/personal/handroid/image_13.webp": "16e31bcb786c9ffcf67aaf625e6dc23d",
"assets/assets/images/personal/handroid/image_3.webp": "3f573e1c42246bd5d68d78700eb44ece",
"assets/assets/images/personal/handroid/image_4.webp": "be3b9fc75c25ca54941d3a7da7d9dffe",
"assets/assets/images/personal/handroid/image_11.webp": "fc981649ba39936425cee56426b5035b",
"assets/assets/images/personal/handroid/image_12.webp": "163afd71d65f200187f6fe529cda01f5",
"assets/assets/images/personal/handroid/image_10.webp": "0d8252cc1cddb69095d85c3743e3f5a4",
"assets/assets/images/personal/handroid/image_9.webp": "e39d133302ca6bc0fc91991cd821e596",
"assets/assets/images/personal/handroid/image_14.webp": "9cfb273bd501ccb264082d23342b16a1",
"assets/assets/images/personal/handroid/image_7.webp": "10c85370702a183e29bd2456ab6cc0e5",
"assets/assets/images/personal/handroid/video_thumbnail_1.webp": "dbebf19f18d6b5b2741a983d5af13f25",
"assets/assets/images/personal/handroid/image_6.webp": "dcfe08bcd100d395300ce6cfbb1e0811",
"assets/assets/images/personal/handroid/image_8.webp": "509a87216eb8019b41451afb85612fe3",
"assets/assets/images/personal/handroid/image_15.webp": "3a990ea6d50526e516d912e56268d7b1",
"assets/assets/images/personal/macro_pad/thumbnail.webp": "0c102c2e715e44ee30bc29e7900abc2e",
"assets/assets/images/personal/macro_pad/image_1.webp": "386b6cf5bbf6192df67cd4f8c4bcff3f",
"assets/assets/images/personal/macro_pad/image_3.webp": "95f2196a2b9309f761252b85175c234a",
"assets/assets/images/personal/macro_pad/image_4.webp": "c7bc1c01e7e247829c2a81752b57be0b",
"assets/assets/images/personal/macro_pad/image_2.webp": "59e976feab75065b5cf34fcb8fdb1dba",
"assets/assets/images/personal/led_wall_decor/thumbnail.webp": "55fc9ad122adb7ed0df8f726a8eb2a07",
"assets/assets/images/personal/led_wall_decor/video_1.m4v": "4ebc4c7354ce473b68cc18b138399658",
"assets/assets/images/personal/led_wall_decor/image_1.webp": "fe6263f10be68ab4340c95eb084668d9",
"assets/assets/images/personal/led_wall_decor/image_3.webp": "ad2f75eaa0f1e1ba81ce87dbe12df37a",
"assets/assets/images/personal/led_wall_decor/image_4.webp": "1787aa8a8ca576992d5755af61b23d0f",
"assets/assets/images/personal/led_wall_decor/video_thumbnail_1.webp": "112c2ca14d39e088d90edcc64812e5fb",
"assets/assets/images/personal/led_wall_decor/image_2.webp": "e32ca6b2dd5e78ef7fd119873a08f41e",
"assets/assets/images/personal/xbox_head_tracking/video_1.mp4": "f21365d9503174f30d115cbfb573219a",
"assets/assets/images/personal/xbox_head_tracking/video_thumbnail_3.webp": "af39e8f2f917f81548ea4191919fa34e",
"assets/assets/images/personal/xbox_head_tracking/thumbnail.webp": "e9d43379c4f05d1bc6692d0db2066f08",
"assets/assets/images/personal/xbox_head_tracking/image_1.webp": "7ceff80a6421ac372ce20ba2a1e52392",
"assets/assets/images/personal/xbox_head_tracking/image_3.webp": "fbf456648dd0126bb2cdb59944b84847",
"assets/assets/images/personal/xbox_head_tracking/video_thumbnail_2.webp": "1f523a3c9398badca70b8ec8818c4494",
"assets/assets/images/personal/xbox_head_tracking/image_5.webp": "1dd9ad22280a30b8ddbbf8dea74b8b7e",
"assets/assets/images/personal/xbox_head_tracking/image_7.webp": "783cb048490e9e02baefb43ce8101d2a",
"assets/assets/images/personal/xbox_head_tracking/video_thumbnail_1.webp": "ca14e9e868cf16acd2c35a49092470b0",
"assets/assets/images/personal/xbox_head_tracking/image_6.webp": "6b15f77aa50a16199e9b00ac2a28a72d",
"assets/assets/images/personal/xbox_head_tracking/video_3.mp4": "cb038b15c811fb00afee760a17a152cd",
"assets/assets/images/personal/xbox_head_tracking/video_2.mp4": "837e370232d5418620d789aba1baf8b0",
"assets/assets/images/personal/xbox_head_tracking/image_2.webp": "9c7f1d59f8e0e0190731416a7de40ebf",
"assets/assets/images/personal/flutter_resume_builder/thumbnail.webp": "d59439af0337157c678ad71ed282eba5",
"assets/assets/images/personal/apple_charging_station/thumbnail.webp": "046c1ffab300af72fa0c782b612c0953",
"assets/assets/images/personal/apple_charging_station/image_1.webp": "bc19992aa51014de549c5a9956628f4e",
"assets/assets/images/personal/apple_charging_station/image_4.webp": "241cc9875e915c7de8640cfcab981b8a",
"assets/assets/images/personal/apple_charging_station/image_5.webp": "8731f313fba125110194440601ee04da",
"assets/assets/images/personal/apple_charging_station/image_9.webp": "e270b1e693e572eeaa7c7a4c197d4c32",
"assets/assets/images/personal/apple_charging_station/image_7.webp": "f9a3a0efa1f1d8784edb7759a72c4095",
"assets/assets/images/personal/apple_charging_station/image_6.webp": "d9da63ec8089a19043ae974644113dab",
"assets/assets/images/personal/apple_charging_station/image_8.webp": "bb1d3d76be4c92661b099f371d5dfea1",
"assets/assets/images/personal/apple_charging_station/image_2.webp": "8c91c54980c2385cfa536ec0153c6a97",
"assets/assets/images/personal/safedrive_mk1/video_1.mp4": "94d8b6e747c6ed60489368aeac680eea",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_3.webp": "43fad3ed4d81546105a86750846751fb",
"assets/assets/images/personal/safedrive_mk1/thumbnail.webp": "9f15a8a4c95489bd1ca3207f3f801be1",
"assets/assets/images/personal/safedrive_mk1/video_4.mp4": "61e565fd54f84f32bcb276f347cbf69c",
"assets/assets/images/personal/safedrive_mk1/image_1.webp": "73f066596a9ccbd05d1946e5381f5f0c",
"assets/assets/images/personal/safedrive_mk1/image_3.webp": "69fdd61198c46908d39a67db7db4fcb4",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_2.webp": "7cee61f2d8aac6f24d47dedcb826346d",
"assets/assets/images/personal/safedrive_mk1/image_4.webp": "e0abe905a692fcbc89e441743fb0d1ab",
"assets/assets/images/personal/safedrive_mk1/image_5.webp": "9677369482a5f5b8d9d348076f96130c",
"assets/assets/images/personal/safedrive_mk1/image_11.webp": "a3b5f388d1c6fd4f1c661d4aa358577b",
"assets/assets/images/personal/safedrive_mk1/image_10.webp": "01e9c186b780ee863ef410173dd34410",
"assets/assets/images/personal/safedrive_mk1/image_9.webp": "63ae6b3ff45a6395ca2865a87cd91298",
"assets/assets/images/personal/safedrive_mk1/image_7.webp": "a502780f51b78b7883e832456b341891",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_1.webp": "5f140f48d0d2401536c1fc98d4faa5c8",
"assets/assets/images/personal/safedrive_mk1/image_6.webp": "4a0cbd875844637c89b12e607550002d",
"assets/assets/images/personal/safedrive_mk1/image_8.webp": "0fb60f06cb131e846bc61923db798f77",
"assets/assets/images/personal/safedrive_mk1/video_3.mp4": "4b6a4a6ce34ca4f8449a3b404c2c2f60",
"assets/assets/images/personal/safedrive_mk1/video_2.mp4": "cee454902c23d32dcef8b06fcdb82892",
"assets/assets/images/personal/safedrive_mk1/image_2.webp": "d243bbadcc78051b032d0480de309302",
"assets/assets/images/personal/safedrive_mk1/video_thumbnail_4.webp": "f8ddc6cae379e9555e7287ee9427e6ef",
"assets/assets/images/professional/atlantic_insurance/thumbnail.webp": "c90aead7eec0a83a4b9469d13a828218",
"assets/assets/images/professional/atlantic_insurance/image_1.webp": "63d31db20a36b3c5c42e286a6b1693bd",
"assets/assets/images/professional/atlantic_insurance/image_3.webp": "cd465456dd9d22f73765db69dac1806b",
"assets/assets/images/professional/atlantic_insurance/logo.webp": "6264dd2adfe428a89e462a33827993b6",
"assets/assets/images/professional/atlantic_insurance/image_2.webp": "f94aa55d7c4bdd52fb82e08e44a9e774",
"assets/assets/images/professional/ambots/thumbnail.webp": "77fa62c51ff47ae7b966f2e4de30495d",
"assets/assets/images/professional/ambots/image_1.webp": "c9c5d84f06484a9680e67483ed7d4de1",
"assets/assets/images/professional/ambots/image_13.webp": "44c1bd8c093d4042402e1643b279c202",
"assets/assets/images/professional/ambots/image_3.webp": "2afd00f9b98ebe52008ca85d9116e5e8",
"assets/assets/images/professional/ambots/image_4.webp": "e55ff5b7fa38f1cef5ee7904e66a17f3",
"assets/assets/images/professional/ambots/image_5.webp": "dbc187c2084eaa1341dd1c112b90de0e",
"assets/assets/images/professional/ambots/image_11.webp": "1e48981733a9ac2bfbaca5c016e0c709",
"assets/assets/images/professional/ambots/image_12.webp": "25cf903c2dc7e1f1287ec6e74e495d4e",
"assets/assets/images/professional/ambots/image_10.webp": "ad8cee2929ff6e27b3c7f536229df367",
"assets/assets/images/professional/ambots/image_9.webp": "8bbf7d4a85b835cad9a6c38a8ceb0bd3",
"assets/assets/images/professional/ambots/video_10.mp4": "ddee026980cc5b014cc8835d01867aa3",
"assets/assets/images/professional/ambots/image_17.webp": "633f3f19dab6420f4af58215b04dcd14",
"assets/assets/images/professional/ambots/image_14.webp": "9f36c95b47f50b307723cf9cc62ef55a",
"assets/assets/images/professional/ambots/image_7.webp": "de9e6d354c420bed7cc087dfb1624ff2",
"assets/assets/images/professional/ambots/image_6.webp": "f3e40007a703fab4ed3c020d04da4631",
"assets/assets/images/professional/ambots/image_16.webp": "243fe62eeb7a84417a2762aa142e6f4d",
"assets/assets/images/professional/ambots/image_8.webp": "b5ad43dbdd1043de3688cb491ceb8468",
"assets/assets/images/professional/ambots/image_18.webp": "720ea8becc8d1265dd15519577967e42",
"assets/assets/images/professional/ambots/image_15.webp": "b46455b4ad15f98d7b417c7482861c69",
"assets/assets/images/professional/ambots/video_thumbnail_10.webp": "a540d3b6fc49a6220dd7095aac410b75",
"assets/assets/images/professional/ambots/logo.webp": "c8329ace9b11d66a240aca1fe05e0aca",
"assets/assets/images/professional/ambots/image_2.webp": "1f465028bdd89107a6889a9386968a79",
"assets/assets/images/professional/ambots/image_19.webp": "2736e4e06b7b9d1848e058a097bb971f",
"assets/assets/images/professional/am3_lab/thumbnail.webp": "556df198873c850619a10544d3213127",
"assets/assets/images/professional/am3_lab/image_1.webp": "3a90dc5b2cf093643b2fc3dd6803965d",
"assets/assets/images/professional/am3_lab/image_3.webp": "14c81ccd4adc45c1fa434674122ee6d3",
"assets/assets/images/professional/am3_lab/image_4.webp": "5c5abd943395eee0258f4950d0e699a3",
"assets/assets/images/professional/am3_lab/image_5.webp": "e155dcb950d6ce0b576afd46085b8c7f",
"assets/assets/images/professional/am3_lab/video_thumbnail_9.webp": "0f0efa75f8803926f4e7d588724c8865",
"assets/assets/images/professional/am3_lab/image_7.webp": "36c329fb5f6eedd4e6db3e99f44545d2",
"assets/assets/images/professional/am3_lab/image_6.webp": "aed8b0acd5034e35e36536cd18f592a9",
"assets/assets/images/professional/am3_lab/video_9.mp4": "ef94275f2b159205aa4cd4c8be20ae40",
"assets/assets/images/professional/am3_lab/logo.webp": "25f9bd41af589eb1cbf4f252e44d95b5",
"assets/assets/images/professional/am3_lab/image_2.webp": "f4957bd1c8b8d67c2f3559cc3f47df72",
"assets/assets/json/education.json": "d8504491f24c4cb530d033911928a5d5",
"assets/assets/json/projects.json": "aba89457da0e184b4c00ea3f14c1ca08",
"assets/assets/json/professional_experience.json": "dc2e77f81a0cf2d67262bfca1c91678f",
"assets/assets/docs/project_descriptions/macro_pad.md": "87881fc024687a340d21f3871da851e8",
"assets/assets/docs/project_descriptions/safedrive_mk1.md": "990013029f7e7395f58cfab1a49bd55a",
"assets/assets/docs/project_descriptions/flutter_resume_builder.md": "4b0aabe6eedcefa1f39391119c6d9858",
"assets/assets/docs/project_descriptions/xbox_head_tracking.md": "cd2522a756933f3ed6e559585b6156fa",
"assets/assets/docs/project_descriptions/mobile_sim_wheel.md": "5c7ce62cb62a759ba57c585dbf7e454d",
"assets/assets/docs/project_descriptions/swe_632_lottery.md": "314c6ac8b288271e615470af3023c379",
"assets/assets/docs/project_descriptions/amg_gt3_wheel.md": "b384ba1bbd9380c2795ecb90a111e6b8",
"assets/assets/docs/project_descriptions/apple_charging_station.md": "38af129f44e204fdfc105b26b7fe4e60",
"assets/assets/docs/project_descriptions/f1_sim_engineer.md": "f17f71a075a93797bad717eaf1b00613",
"assets/assets/docs/project_descriptions/switch_speaker.md": "5b12ec1db4917928f103f072beb8dffc",
"assets/assets/docs/project_descriptions/led_wall_decor.md": "7ef54c9ae2729d3a0533afbe4e512d8e",
"assets/assets/docs/project_descriptions/android_calculator.md": "7d4422bf4512499ccb3eac47f314de43",
"assets/assets/docs/project_descriptions/blokus.md": "1dccae87eecea64d21046423e03f92a4",
"assets/assets/docs/project_descriptions/project_lemans.md": "8ee86275276ceafd3da82854cd71888b",
"assets/assets/docs/project_descriptions/handroid.md": "fe4275f314a684bcde9d56b7538c50e7",
"assets/assets/docs/professional_descriptions/ambots.md": "e7f4c935e2649988bf9770296ebb87eb",
"assets/assets/docs/professional_descriptions/atlantic_insurance.md": "6046e2826f76ea43305f61a4f43dc877",
"assets/assets/docs/professional_descriptions/am3_lab.md": "64be4b8d53f70702673d72910b7dafd8",
"assets/AssetManifest.bin.json": "e8be693bc131e6a9979d5733a8f904db",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6b0522aa5ed3f97adc713f7170dc9b91",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "45687924601df0902801fe5693e5a949",
"assets/fonts/MaterialIcons-Regular.otf": "fdb7b347b6b74e1813e8c503a9af44df",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d8e2f9c3542938ee68bc269d29cc0850",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"main.dart.js": "c78c810331c0bcea97b3529cdedf3ec6",
"icons/Icon-512.png": "f36784eff5543ff42bbb1deef86fcfdf",
"icons/Icon-192.png": "f0af3cd2604c8d51a592c97f9f3b7de2",
"icons/Icon-maskable-512.png": "f36784eff5543ff42bbb1deef86fcfdf",
"icons/Icon-maskable-192.png": "f0af3cd2604c8d51a592c97f9f3b7de2",
"flutter_bootstrap.js": "9dcd244e5c4f4edb6f92b1451745a7ee",
"favicon.png": "96ac6ad69daa95a323b0fe73c3c8dcce",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"index.html": "547055cc685f60bd99cb9fcaa99299f6",
"/": "547055cc685f60bd99cb9fcaa99299f6",
"version.json": "72ed205b7efbc4bd9b0910b90b8bf945",
"manifest.json": "b8bb80c94c29e93bf4dec35ebffe4a15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
