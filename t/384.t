use strict;
use warnings;
use Test::More tests => 68;
use Digest::SIMD qw(simd_384 simd_384_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::SIMD->new(384)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            simd_384_hex($data), $digest,
            "simd_384_hex: $len bits of $msg"
        );
        ok(
            simd_384($data) eq pack('H*', $digest),
            "simd_384: $len bits of $msg"
        );
    }

    my $md = Digest::SIMD->new(384)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $msg");
}
continue { $len++ }

__DATA__
00|5FDD62778FC213221890AD3BAC742A4AF107CE2692D6112E795B54B25DCD5E0F4BF3EF1B770AB34B38F074A5E0ECFCB5
00|27811142C73C91E56DC7AE3E0CF1AC1B1D97135BF299FBA7EEB7997F87F79892C6327285CA3F048CE0BA268ED9BE5D30
C0|5FFC384EDB186A9858AADF5BB1D1205C32829483AA542FDA17DF94E4BF648C1F3CA7C9482AFCF2FE20F2736CDE6BBF14
C0|206C8B9F199F080FA0E3D63B3B97744A5BD02959F11ED011B4F9AAB5EAF9A10CE7F21E33BBB13EE0EC8C5762F791540A
80|78C70BA32E9CE498AF829BC47E61F93EC7C2D995CC6CF260BB8C2AB4D5131C118DD53F516945B8B089255454F1373C40
48|2116FA55B0210CB0639C8EFD51936857DB02F2B192F53149F8FED5A22E07B8BC85BFA53C1DB9200A7327E7ECFFD2A864
50|7BBBEF1D8EE75CB3C41A9F604E17CB448C0442AE6D89566DE7FE10D7694A641C735A38DF4F209909A47AA5E90E6084DA
98|9C3572A84DFBD901FCA878C299628157521C774632A7882EA030BE2F2FEA5F13B553558A30703D0B4024E6D0816982AC
CC|33154248A9E2BDA03D5E3704EF2871C33365D4BA176BC02FF71E00A28C4630F3B8B74239A480A743867F4E984B7B842F
9800|3E02A4D687864BBD9B381AAB259BDF28ECCBB332935BF8A3BE87175B571D76772EDB651276D3BEA72DCC9FA08383D093
9D40|0D73C5BAF58F6EA682EA3C8CFD9F81EABC9A1BDF907ACA13848DDA757C5175A28B6E6E96B44A15EEBD6675B4D5A092AA
AA80|5600AC500107C08213D3C68D176CC736FA4AEC8772C28489886951ECEAD4EC73BF544CB01DCF65C38E7360E3739FE2D7
9830|11251F9A10632E34AAC310927B6AD70866B4276C751EBA85F7291FFDB56BE291D30A35ABDFD555FE63E8198FBE40378C
5030|A9F4B666757C2A4430C55E421EA1FE2E717A29D121E699238E4A33C248E98EA8805277894EC3C47473B82C4031D65D10
4D24|12CFDB5BA4A130FFE882505858CA2B21D7AB5FE8929179C061AA885F8842054E832DDDA355E70CF49E9C146803DB331E
CBDE|5D90AC46E486434438AA62B8252F87585105E1623EDEC3F7952763D104EF60793842C27C0C03A7C5FB1A726002BA687B
41FB|532EB0AF028EBFACE47EEB76CE30988A8CA1B116F18A9F2C334C89D5DBB20D0AF9B5631C7BDA11ACA58807C8C81F8F1A
4FF400|DBB0875F469256A28D4787617322AACFE0DC21D1CD757B2E539ECBFE7760402AEA084621D45765F741556AE8C3D43826
FD0440|7839AC9B9A4674269C0B61F5FC0AEC5F71F4087C001CCB67E2AFBA792036BF4451ED398807AE5D6BC3EE85C4E1185DB8
424D00|0E252FFF4385AFACD8F7E0145E3FB7E06095CCE50BF6B152812619CE02A411502382C636700D7C341D32DF3FDB427096
3FDEE0|8471F40B723CA9B12A5C9AB5CAC7883ECBE1F6F45105E7DDFB94D069A92B1C414922D5405829F68AE45474DDDAC09932
335768|5234E504CC67092EC38F637399682A7875A9F9FED2C238D5901C5294189D1945EF3F9D27AC4F9185273BD38EC68545D8
051E7C|D309D398B690797279162F3D731F13C560E509BAC88DBE15E40236F09DDF888E8D606DAF0D0BC0C920CCA02794376106
717F8C|5E0052922ACB9AAEC0B0965139E0612E4079725C09573F4BD90071263B584D461579CFEB0820C6347B1ED3AD12E761A9
1F877C|D0E2373343277839B89DF8DBD79A6A7D0A8A8026FB2D7B2F02300A8785CCAEC567612A56E4DDD16BEA238C6ED4832AEB
EB35CF80|E71EEC88C81559ADFE92B81ED45C0B411E36A4ADC31B3141788F79AA0D5DE6BB14C9707D0321524D46B34A649AACFBAD
B406C480|4408AF4296DFF92E7B00FAA53A726B60DF6673E552B4E8742DA118BE5044D081AA69489A410DCAEFFB2CCAA634D49FE6
CEE88040|2F354CF925B3AB9033408FB01468BA02A7D9AEF4C187F46A50D108F5E226284D0797F418E60E659DCD3C59AAFB874339
C584DB70|074C461AD82291AD3ADCD029DFC2168FABB1C91F3192C952D08B2E482A0F2AE2C1BE90BCB0B4F74E4F215E109A7B1450
53587BC8|A48304A8E49AD8710A66C6ADBFFE37E11B88656EBA36A7118A71A3AA4ADFA32FF34AC8008DFE3CF969669AF5BABFFD92
69A305B0|79C2ABAB26B4B27C797EA8AA6EC58860AB7B332888EDBC15A4319E16842F7A72183C1F29152BC136A0F72E7161A41E40
C9375ECE|CDDC3C18116F27D2FD98BB8A6434DB118D205FBE621119C5866A609D8CECA8DA6C6BADC3BA66E0BDB5D7AF5B12657182
C1ECFDFC|69D25FFF1040271946848368DC115111ECC2EBD5C453FBB6B4861FFA2AF1B74294BDDDD4117932E22D858A3463471FBD
8D73E8A280|FB5EEE8479E1D6CB5C148C1D3006C4CDBCCE89C99DB7BB49B2FB6B50A2168203E00A865DA00897021C266FB67D3E69A8
06F2522080|B267788319A9E0CD6B03E16510E3FFBC004539215FBC27A6124DD557C8EA003BDEDB2453E9DE29BFBB0433C8FA30107E
3EF6C36F20|C06A4C6C6FC5B660A75CBBBE4FAD55DB31F9A59B95AEB183C5B7DFD47E1AE1CDD930FD14960B56B063C97218E15566AD
0127A1D340|33693FD156F180CB88B63CE8A21181E010ADBF122B4FAE64CF862E1F556F6D77CB75B941E75EE96EEF43475C5B6B7DA2
6A6AB6C210|1E2355F18F73CFE02798DB83BB4BB697370BD60AB2FAC6089D57C7EEDE0C781328853A12F917FCB1269763C82C5E193E
AF3175E160|4BE35C4F78830F17E8FE24EAA12C484B505AF6480D98852FD5AAECA3510F43A20A841E851938E6E024D8CC2759956F1A
B66609ED86|A7B17D1D641C801120BE9AC799F19869B6F71E495E5DE207A4AE9D1B558DC88ACABBDE6CE2EF85B96BAEB7D50256E73D
21F134AC57|169BEEDC7E8CB2E39F5EAD6139B69F5053FC7917812C8EECD06875540F1DB8919FB7C62F3C257D21B001C9250AFF28A7
3DC2AADFFC80|85EF263C1857E7FD2350BF4730A80911A7A34522D93BF5352961F54012CAFA261E66AB9303A4AB20091E0011809868AB
9202736D2240|DA693502B5C50F2CCA183A76EF079F5F29C10D9543F4E9FAE6030399E2EA284BC04440FE19A04F3811BFE893E92C9A0D
F219BD629820|8BF78ACF5431E7DA191DB2C1827E34B288E89E28B8D61A6AF1851A0AC24833480ECB691603569480A8D37F38BF4C21B6
F3511EE2C4B0|BCC2E0A0A9AB7335A38CBC605D49CF1E81F5F830EF824E4029D31D9CAD5534F49C718E25F9E54872ADA00DD9DD71DA1A
3ECAB6BF7720|141D283A76011925934F3F39F75DE4A26F4CAFE788D0490C842C501ED5CDE9FADDB77678EAC39A42CDE0DD9B3AD16F18
CD62F688F498|379E26A2966A3AB60736AB74CF43DB7FA13C5F9809A11C08793296510A96B58FB264801C84BE83155A0FBA41846E0A92
C2CBAA33A9F8|55797FDA29BDB1548C5E793F6505DA9F4AD6981A6BCFE1869C2B912A5085EAA0E9FA2903AE34DE213ABE816530F167E1
C6F50BB74E29|D28D7B9374D28EC468A9C2055807FAF35F0AAA857A558E58948EA03E11541836D70173A4CE2F84EC4B14C04B1494F4BC
79F1B4CCC62A00|BF810E9DCC5A5E226E031D4037A4DDDE97BBB68664AF8D811183B32832653B05894828D7A1891D0F6B847383A132A1C0