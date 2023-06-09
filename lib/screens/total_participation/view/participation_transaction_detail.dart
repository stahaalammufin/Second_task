import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task/core/constants/app_words.dart';
import 'package:task/util/time_converter.dart';

import '../../../model/payment_details.dart';
import '../../../util/snack_bar_util.dart';
import '../../../widgets/button.dart';
import '../bloc/participation_bloc.dart';
import 'dart:ui' as ui;
 GlobalKey _globalKey = new GlobalKey();
class ParticipationDetails extends StatefulWidget {
  const ParticipationDetails({super.key, required this.uuid});

  static Route route(uuid) {
    return MaterialPageRoute<void>(
      builder: (_) => ParticipationDetails(
        uuid: uuid, //saving the callback that is sent by the parent class
      ),
    );
  }

  final String uuid;

  @override
  State<ParticipationDetails> createState() => _ParticipationDetailsState();
}

class _ParticipationDetailsState extends State<ParticipationDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future<bool>.value(true);
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text(
              '거래확인증',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            ],
            bottom: PreferredSize(
                child: Container(
                  color: Color(0xFFDCDEE6),
                  height: 2.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
          ),
          body: BlocConsumer<ParticipationBloc, ParticipationState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              SnackBarUtil.critical(text: state.errorMessage);
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.paymentDetail != null) {
                return ParticipationDetailsScreen(
                  paymentDetail: state.paymentDetail!,
                );
              } else {
                return const Center(child: Text(AppWords.noDataFound));
              }
            },
          ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25,bottom: 10),
          child: SizedBox(height: 52,child: BottomButton(buttonText: '거래확인증 저장',callback: ()async {
            Uint8List? data = await _capturePng();
            if (data != null) {
              shareImage(await _createFileFromString(data));
          }
          })),
        ),
        ),
      ),
    );

  }

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    context.read<ParticipationBloc>().add(GetPaymentDetailEvent(widget.uuid));
  }


  Future<String> _createFileFromString(Uint8List data) async {
    String dir = (await getTemporaryDirectory()).path;
    String fullPath =
        '$dir/${DateTime.now().toString().replaceAll(" ", '')}.png';

    print("local file full path ${fullPath}");

    File file = File(fullPath);
    try {
      file.writeAsBytesSync(data);
      return file.path;
    } catch (e) {
      print('Error saving file: $e');
      return '';
    }

  }

  Future<Uint8List?> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData?.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes!);
      print(pngBytes);
      print(bs64);
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void shareImage(String path) {
    Share.shareXFiles(
      [XFile(path)],
    );
  }
}

class ParticipationDetailsScreen extends StatelessWidget {
  final PaymentDetails paymentDetail;

  const ParticipationDetailsScreen({super.key, required this.paymentDetail});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(right: 25, left: 25),
      children: [
        const SizedBox(
          height: 24,
        ),
        RepaintBoundary(
            key: _globalKey,child: DetailsCard(paymentDetail: paymentDetail)),
        const SizedBox(
          height: 24,
        ),
        const Text(
          '- 위의 내용이 정상적으로 거래되었음을 확인합니다.',
          style:  TextStyle(
            color: Color(0xFF838799),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),const Text(
          '- 거래확인증은 고객 편의를 위해 제공되는 것으로, 현금영수증, 매출전표 등 증빙서류로 사용하실 수 없습니다.',
          style:  TextStyle(
            color: Color(0xFF838799),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),const Text(
          '- 본 확인증을 임의로 위·변조하여 행사할 경우 형법 (제251조 및 234조)에 따라 처벌받을 수 있습니다.',
          style:  TextStyle(
            color: Color(0xFF838799),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),

      ],
    );
  }
}

class DetailsCard extends StatelessWidget {
  final PaymentDetails paymentDetail;

  const DetailsCard({super.key, required this.paymentDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // if you need this
        side: BorderSide(
          color: Color(0xFFDCDEE6),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            DetailsListItem(title: '거래번호', value: paymentDetail.uuid ?? ''),
            const SizedBox(
              height: 16,
            ),
            DetailsListItem(title: '거래명', value: '${paymentDetail.dailyPayoutMsq}MSQ\n(전송일시 ${paymentDetail.createdAt?.getmmDDDate() ?? ' '})' ?? ''),
            const SizedBox(
              height: 16,
            ),
            DetailsListItem(title: '지급금액', value: '${paymentDetail.dailyPayout?.toString()}원' ?? ''),
            const SizedBox(
              height: 16,
            ),DetailsListItem(title: '받는사람', value: paymentDetail.userName ?? ' '),
            const SizedBox(
              height: 16,
            ),DetailsListItem(title: '은행명', value: paymentDetail.bankName ?? ' '),
          const SizedBox(
              height: 16,
            ),DetailsListItem(title: '계좌번호', value: paymentDetail.bankAccountNumber ?? ' '),
           const SizedBox(
              height: 16,
            ),DetailsListItem(title: '거래일시', value: '${paymentDetail.createdAt?.getyyyymmddhhmmssDate()}' ?? ' '),
          const SizedBox(
              height: 24,
            ),
            const Divider(
              color: Color(0xFFDCDEE6),
              height: 1,
            ),
            const SizedBox(
              height: 24,
            ),
            DetailsListItem(title: '보낸사람', value: paymentDetail.userName ?? ' '),
            const SizedBox(
              height: 16,
            ),
            const DetailsListItem(title: '주소', value: '서울시 서초구 강남대로53길 8 8층 2-11호'),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsListItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailsListItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    debugPrint('the value is $value');
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF838799),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
