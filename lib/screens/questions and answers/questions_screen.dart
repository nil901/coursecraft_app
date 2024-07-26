import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/course/course_details_screen.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:coursecraft_app/screens/questions%20and%20answers/questions_answers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List questionListData = [
  '1. How to remove borders applied in Cells?',
  '2. How to remove borders applied in Cells?',
  '3. How to remove borders applied in Cells?',
  '4. How to remove borders applied in Cells?',
  '5. How to remove borders applied in Cells?',
  '6. How to remove borders applied in Cells?',
  '7. How to remove borders applied in Cells?',
  '8. How to remove borders applied in Cells?',
  '9. How to remove borders applied in Cells?',
  '10. How to remove borders applied in Cells?',
];
List<Map<String, dynamic>> questions = [
  {
    'question': 'What is the file extension of an Excel workbook?',
    'answers': ['.xls', '.xlsx', '.xlsm', '.xltx'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'Which option in Excel allows you to undo the last action?',
    'answers': ['Redo', 'Repeat', 'Undo', 'Backtrack'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'To move to the last cell in a worksheet, you can use the shortcut:',
    'answers': ['Ctrl + Home', 'Ctrl + End', 'Ctrl + Shift + Home', 'Ctrl + Shift + End'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'What is the function of the "SUM" function in Excel?',
    'answers': ['It calculates the average of a range of cells.', 'It finds the maximum value in a range of cells.', 'It adds the values in a range of cells.', 'It multiplies the values in a range of cells.'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which of the following is a correct formula to multiply the values in cell A1 and B1?',
    'answers': ['=MULT(A1, B1)', '=A1 * B1', '=SUM(A1, B1)', '=PRODUCT(A1, B1)'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'The function COUNTIF in Excel is used to',
    'answers': ['Count the total number of cells in a range.', 'Sum up the values in a range of cells.', 'Count the number of cells that meet a specific condition.', 'Calculate the average of a range of cells.'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which Excel function can be used to find the highest value in a range?',
    'answers': ['MAX', 'HIGH', 'LARGE', 'TOP'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'Conditional formatting in Excel allows you to:',
    'answers': ['Add conditional statements to formulas.', 'Automatically format cells based on specific criteria.', 'Hide specific cells based on conditions.', 'Sort data in ascending or descending order.'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'To insert a new row in Excel, you can right-click on:',
    'answers': ['The row header', 'The column header', 'Any cell in the row', 'The worksheet tab'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'The formula =INDEX(A1:A10, 5) will return the value from:',
    'answers': ['The fifth cell in the range A1:A10', 'The last cell in the range A1:A10', 'The cell in the fifth row of column A', 'The cell in the first row of column A'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'The VLOOKUP function in Excel is used to:',
    'answers': ['Vertically align the data in a worksheet.', 'Create a virtual table within a worksheet.', 'Lookup and retrieve data from a specific column in a table.', 'Validate the data entered in a worksheet.'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'How do you freeze panes in Excel?',
    'answers': ['Go to the View tab and click on Freeze Panes.', 'Press Ctrl + F.', 'Right-click on a cell and select Freeze Panes.', 'Use the Freeze option from the Home tab.'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'Which Excel function allows you to extract a specific portion of text from a cell?',
    'answers': ['TRIM', 'EXTRACT', 'LEFT', 'SPLIT'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'In Excel, what is the purpose of the "Watch Window" feature?',
    'answers': ['To keep an eye on the formula bar while entering data.', 'To display the formulas and values of cells in a separate window.', 'To watch a movie in Excel (a joke answer).', 'To display a list of watch items that you can monitor while working on other parts of the workbook.'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'How can you find and remove duplicates in Excel?',
    'answers': ['By using the Remove Duplicates option under the Home tab.', 'By using the Delete key on the keyboard.', 'By sorting the data in ascending order.', 'By manually reviewing each cell for duplicates.'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'What does the COUNT function in Excel do?',
    'answers': ['It counts the total number of cells in a range.', 'It counts the number of cells containing numbers in a range.', 'It counts the number of non-empty cells in a range.', 'It counts the number of cells meeting a specific condition in a range.'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'The formula =IF(A1>10, "Yes", "No") will return "Yes" if:',
    'answers': ['Cell A1 is greater than 10.', 'Cell A1 is equal to 10.', 'Cell A1 is less than 10.', 'Cell A1 contains the text "Yes."'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'Which function in Excel allows you to round a number to the nearest integer or a specified number of decimal places?',
    'answers': ['ROUNDUP', 'ROUNDDOWN', 'ROUND', 'INT'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'The formula =SUMIF(A1:A10, ">50") will:',
    'answers': ['Sum all the values in the range A1:A10.', 'Sum all the values greater than 50 in the range A1:A10.', 'Count the number of cells with values greater than 50 in the range A1:A10.', 'Return an error as the formula is incorrect.'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'The formula =AVERAGE(A1:A10) will calculate:',
    'answers': ['The total sum of the values in the range A1:A10.', 'The average of the values in the range A1:A10.', 'The highest value in the range A1:A10.', 'The lowest value in the range A1:A10.'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'Which chart type is best suited for comparing individual data points to a whole?',
    'answers': ['Line chart', 'Bar chart', 'Scatter plot', 'Pie chart'],
    'correctAnswerIndex': 3,
  },
  {
    'question': 'The horizontal axis in an Excel chart is also known as the:',
    'answers': ['Y-axis', 'X-axis', 'Category axis', 'Value axis'],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'What is the purpose of using a secondary axis in an Excel chart?',
    'answers': ['To plot data in a different color.', 'To create a 3D effect on the chart.', 'To display two different sets of data on separate vertical axes.', 'To add a title to the chart.'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which chart type is best suited for showing trends over time?',
    'answers': ['Scatter plot', 'Bar chart', 'Line chart', 'Area chart'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'How can you add data labels to a chart in Excel?',
    'answers': ['Right-click on the chart and select "Add Data Labels."', 'Go to the Chart Design tab and click on "Data Labels."', 'Data labels are automatically added when you create a chart.', 'Data labels cannot be added in Excel.'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'What is the purpose of a pivot table in Excel?',
    'answers': ['To create a summary report based on a dataset.', 'To display the raw data in a table format.', 'To perform calculations on data in a worksheet.', 'To create charts and graphs.'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'Which Excel function can be used to find the average of a dataset, excluding the highest and lowest values?',
    'answers': ['AVERAGEIF', 'AVERAGEA', 'AVERAGEIFS', 'AVERAGEIFNOT'],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'The "What-If Analysis" tool in Excel is used to:',
    'answers': ['Compare two datasets side by side.', 'Display a list of frequently used functions.', 'Perform sensitivity analysis by changing input values.', 'Merge multiple worksheets into a single workbook.'],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'In Excel, which function is used to find the smallest value in a range of cells that meets a specific condition?',
    'answers': ['SMALL', 'MIN', 'LOOKUP', 'VLOOKUP'],
    'correctAnswerIndex': 2,
  }
];
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
    List<int> selectedAnswerIndexes = List.generate(10, (index) => -1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  appBar(),
                  sizeBoxHeight(25),
                  questionList(),
                   Spacer(),
                  startButton(),
                  sizeBoxHeight(25),
                ],
              ),
            ),
          ),
          Expanded(child: homeFrameImage())
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
              Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                return CourseDetailsScreen();
              },
            ));
          },
          child: Image.asset('${AppImages.courseImages}backarrow.png', height: 13.h)),
        AppText(
            text: 'Questions and Answers',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset('${AppImages.courseImages}backarrow.png',
              height: 13.h, color: Colors.transparent),
        ),
      ],
    );
  }

  Widget questionList() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: questionListData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 13.h),
            child: Container(
              height: 41.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: AppColor.grey2color, width: 2),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    AppText(
                        text: questionListData[index],
                        color: AppColor.blackcolor,
                        fontWeight: FontWeight.w400,
                        fontsize: 11.sp),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget startButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return const CourseDetailsScreen();
          },
        ));
      },
      child: Container(
        height: 48,
        width: 205,
        decoration: BoxDecoration(
            color: AppColor.blackcolor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: AppText(
              text: 'Start Exam',
              color: AppColor.whitecolor,
              fontWeight: FontWeight.w600,
              fontsize: 15.sp),
        ),
      ),
    );
  }
}
