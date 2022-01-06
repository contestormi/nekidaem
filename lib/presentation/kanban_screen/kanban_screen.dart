import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nekidaem/data/models/card_model.dart';
import 'package:nekidaem/main.dart';
import 'package:nekidaem/presentation/kanban_screen/kanban_bloc/kanban_bloc.dart';
import 'package:nekidaem/presentation/theme.dart';
import 'package:nekidaem/widgets/card_widget.dart';

class KanbanScreen extends StatefulWidget {
  const KanbanScreen({Key? key}) : super(key: key);

  @override
  State<KanbanScreen> createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  @override
  void initState() {
    context.read<KanbanBloc>().add(KanbanStartLoading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KanbanBloc, KanbanState>(
      builder: (context, state) {
        if (state is KanbanLoading) {
          return const KanbanBody(loading: true);
        } else if (state is KanbanLoaded) {
          return KanbanBody(
            loading: false,
            listOfCards: state.listOfCards,
          );
        } else if (state is KanbanError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.grey,
            textColor: AppColors.white,
            fontSize: 12.0,
          );
          return const KanbanBody(loading: true);
        } else {
          return const KanbanBody(loading: true);
        }
      },
    );
  }
}

class KanbanBody extends StatelessWidget {
  const KanbanBody({
    Key? key,
    this.listOfCards,
    required this.loading,
  }) : super(key: key);
  final List<CardModel>? listOfCards;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: AppBar(
          actions: [
            RawMaterialButton(
              onPressed: () {
                context.read<KanbanBloc>().add(KanbanLogout());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyApp(
                      loggedIn: false,
                    ),
                  ),
                );
              },
              fillColor: AppColors.aquamarine,
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
              shape: const CircleBorder(),
            ),
          ],
          backgroundColor: AppColors.lightBlack,
          bottom: TabBar(
            indicatorColor: AppColors.aquamarine,
            tabs: [
              Tab(
                child: Text(
                  'on_hold'.tr(),
                  softWrap: false,
                  style: TextStyles.fadedText,
                ),
              ),
              Tab(
                child: Text(
                  'in_progress'.tr(),
                  softWrap: false,
                  style: TextStyles.fadedText,
                ),
              ),
              Tab(
                child: Text(
                  'needs_review'.tr(),
                  softWrap: false,
                  style: TextStyles.fadedText,
                ),
              ),
              Tab(
                child: Text(
                  'approved'.tr(),
                  softWrap: false,
                  style: TextStyles.fadedText,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            loading
                ? const Center(child: CircularProgressIndicator())
                : CardColumn(
                    listOfCards: listOfCards!,
                    columnNumber: 0,
                  ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CardColumn(
                    listOfCards: listOfCards!,
                    columnNumber: 1,
                  ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CardColumn(
                    listOfCards: listOfCards!,
                    columnNumber: 2,
                  ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CardColumn(
                    listOfCards: listOfCards!,
                    columnNumber: 3,
                  ),
          ],
        ),
      ),
    );
  }
}

class CardColumn extends StatelessWidget {
  const CardColumn(
      {Key? key, required this.listOfCards, required this.columnNumber})
      : super(key: key);
  final List<CardModel> listOfCards;
  final int columnNumber;

  @override
  Widget build(BuildContext context) {
    List<CardModel> column = listOfCards
        .where((element) => element.row == columnNumber.toString())
        .toList();

    return ListView.builder(
      itemCount: column.length,
      itemBuilder: (context, index) {
        return CardWidget(
          id: column[index].id,
          textBody: column[index].text,
        );
      },
    );
  }
}
