import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/core/values/images.dart';
import 'package:lms/app/data/models/questions.dart';

import '../controllers/exercise_questions_form_controller.dart';

class ExerciseQuestionsFormView
    extends GetView<ExerciseQuestionsFormController> {
  const ExerciseQuestionsFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueBackground,
          title: const Text('Latihan Soal'),
          centerTitle: true,
        ),
        body: Obx(() {
          int activeQuestionIndex = controller.activeQuestionIndex.value;
          if (controller.questionList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          QuestionListData activeQuestion =
              controller.questionList.value[activeQuestionIndex];
          String activeQuestionId = controller.activeQuestionId;
          String? selectedAnswer = controller.questionAnswers
              .firstWhereOrNull(
                  (element) => element.questionId == activeQuestionId)
              ?.answer;
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    controller.questionList.value.length,
                    (index) {
                      bool isSelected = index == activeQuestionIndex;

                      return InkWell(
                        onTap: () {
                          controller.navigateToQuestionIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w400,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(18),
                  children: [
                    // Judul/Pertanyaan Soal
                    HtmlWidget(
                      activeQuestion.questionTitle ?? '',
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // Opsi Jawaban
                    RadioListTile(
                      title: HtmlWidget(activeQuestion.optionA ?? ''),
                      value: 'A',
                      groupValue: selectedAnswer,
                      onChanged: (val) {
                        controller.updateAnswerToQuestion(
                            questionId: activeQuestionId, answer: 'A');
                      },
                    ),
                    RadioListTile(
                      title: HtmlWidget(activeQuestion.optionB ?? ''),
                      value: 'B',
                      groupValue: selectedAnswer,
                      onChanged: (val) {
                        controller.updateAnswerToQuestion(
                            questionId: activeQuestionId, answer: 'B');
                      },
                    ),
                    RadioListTile(
                      title: HtmlWidget(activeQuestion.optionC ?? ''),
                      value: 'C',
                      groupValue: selectedAnswer,
                      onChanged: (val) {
                        controller.updateAnswerToQuestion(
                            questionId: activeQuestionId, answer: 'C');
                      },
                    ),
                    RadioListTile(
                      title: HtmlWidget(activeQuestion.optionD ?? ''),
                      value: 'D',
                      groupValue: selectedAnswer,
                      onChanged: (val) {
                        controller.updateAnswerToQuestion(
                            questionId: activeQuestionId, answer: 'D');
                      },
                    ),
                    RadioListTile(
                      title: HtmlWidget(activeQuestion.optionE ?? ''),
                      value: 'E',
                      groupValue: selectedAnswer,
                      onChanged: (val) {
                        controller.updateAnswerToQuestion(
                            questionId: activeQuestionId, answer: 'E');
                      },
                    ),

                    if (activeQuestionIndex <
                        controller.questionList.value.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          controller
                              .navigateToQuestionIndex(activeQuestionIndex + 1);
                        },
                        child: const Text('SELANJUTNYA'),
                      )
                    else
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () {
                          Get.bottomSheet(
                            Wrap(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(ImagesAssets.endQuestions),
                                    const SizedBox(height: 16),
                                    const Text(
                                        'Kumpulkan latihan soal sekarang?'),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        const SizedBox(width: 32),
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Nanti Dulu'),
                                          ),
                                        ),
                                        const SizedBox(width: 32),
                                        Expanded(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.submitAnswers();
                                              },
                                              child: const Text('Ya')),
                                        ),
                                        const SizedBox(width: 32),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                  ],
                                ),
                              ],
                            ),
                            backgroundColor: Colors.white,
                          );
                        },
                        child: const Text('KUMPULIN'),
                      ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
