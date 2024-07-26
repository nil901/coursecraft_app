import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/course/course_details_screen.dart';
import 'package:coursecraft_app/screens/utils/prefs/PreferencesKey.dart';
import 'package:coursecraft_app/screens/utils/prefs/app_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsAnswersScreen extends StatefulWidget {
  const QuestionsAnswersScreen(
      {super.key, this.indexquetions, required this.onRefresh});
  final indexquetions;
  final VoidCallback onRefresh;

  @override
  State<QuestionsAnswersScreen> createState() => _QuestionsAnswersScreenState();
}

class _QuestionsAnswersScreenState extends State<QuestionsAnswersScreen> {
  // List to keep track of selected answer index for each question
  List<int> selectedAnswerIndexes = List.generate(10, (index) => -1);

  List<Map<String, dynamic>> questions = [
    {
      'question':
          'Which Excel function is used to find the average of a range of cells?',
      'answers': ['SUM', 'COUNT', 'MAX', 'AVERAGE'],
      'correctAnswerIndex': 3,
    },
    {
      'question':
          'Which Excel function is used to calculate the total number of cells in a range that contain numbers?',
      'answers': ['AVERAGE', 'SUM', 'COUNT', 'MAX'],
      'correctAnswerIndex': 2,
    },
    {
      'question':
          'Which Excel function is used to find the highest value in a range of cells?',
      'answers': ['COUNT', 'AVERAGE', 'MAX', 'SUM'],
      'correctAnswerIndex': 2,
    },
    {
      'question':
          'Which Excel function is used to calculate the square root of a number?',
      'answers': ['SQRT', 'ROUND', 'POWER', 'PRODUCT'],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which Excel function is used to calculate the total product of a range of cells?',
      'answers': ['AVERAGE', 'SUM', 'COUNT', 'PRODUCT'],
      'correctAnswerIndex': 3,
    },
    {
      'question':
          'Which Excel function is used to concatenate (combine) text from multiple cells into a single cell?',
      'answers': ['CONCATENATE', 'SUM', 'COUNT', 'MAX'],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which Excel function is used to find the smallest value in a range of cells?',
      'answers': ['MIN', 'COUNT', 'AVERAGE', 'SUM'],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which Excel function is used to round a number to the nearest integer or specified decimal places?',
      'answers': ['SUM', 'ROUND', 'COUNT', 'MAX'],
      'correctAnswerIndex': 1,
    },
    {
      'question':
          'Which Excel function is used to calculate the total number of cells in a range that are not empty?',
      'answers': ['COUNTA', 'SUM', 'AVERAGE', 'MAX'],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which Excel function is used to find the largest value that is less than or equal to a specified value in a sorted array or range of cells?',
      'answers': ['VLOOKUP', 'HLOOKUP', 'MATCH', 'INDEX'],
      'correctAnswerIndex': 0,
    },
  ];
  List<Map<String, dynamic>> index3 = [
    // Existing questions...
    {
      'question':
          'Which Excel function is used to evaluate multiple conditions using the "AND" operator?',
      'answers': ['IF', 'OR', 'AND', 'NOT'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'The IF function in Excel allows you to:',
      'answers': [
        'Perform mathematical calculations.',
        'Evaluate multiple conditions.',
        'Create charts and graphs.',
        'Sort data in ascending order.'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'The formula "=IF(A1>10, "Yes", "No")" will return "Yes" if:',
      'answers': [
        'The value in cell A1 is greater than 10.',
        'The value in cell A1 is less than or equal to 10.',
        'The value in cell A1 is equal to 10.',
        'The value in cell A1 is not a number.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What does the SMALL function in Excel do?',
      'answers': [
        'Returns the smallest value in a range or array.',
        'Converts a value to uppercase.',
        'Calculates the average of a range.',
        'Rounds a number to a specified decimal place.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'The formula "=AND(A1>10, B1<20)" will return TRUE if:',
      'answers': [
        'The value in cell A1 is greater than 10 and the value in cell B1 is less than 20.',
        'The value in cell A1 is less than or equal to 10 and the value in cell B1 is greater than or equal to 20.',
        'Either the value in cell A1 is greater than 10 or the value in cell B1 is less than 20.',
        'Neither the value in cell A1 is greater than 10 nor the value in cell B1 is less than 20.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which function is used to find the nth largest value in a range?',
      'answers': ['LARGE', 'SMALL', 'IFERROR', 'COUNTIF'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'In Excel, cell referencing is used to:',
      'answers': [
        'Create charts and graphs.',
        'Perform mathematical calculations.',
        'Apply conditional formatting.',
        'Refer to cells in formulas or functions.'
      ],
      'correctAnswerIndex': 3,
    },
    {
      'question': 'The formula "=OR(A1>10, B1<20)" will return TRUE if:',
      'answers': [
        'The value in cell A1 is greater than 10 or the value in cell B1 is less than 20.',
        'The value in cell A1 is less than or equal to 10 and the value in cell B1 is greater than or equal to 20.',
        'Both the value in cell A1 is greater than 10 and the value in cell B1 is less than 20.',
        'Neither the value in cell A1 is greater than 10 nor the value in cell B1 is less than 20.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'What is the result of the formula "=IF(AND(A1>10, B1<20), "True", "False")" if the value in cell A1 is 15 and the value in cell B1 is 18?',
      'answers': ['True', 'False', '#VALUE!', '#NAME?'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'The LARGE function in Excel is used to:',
      'answers': [
        'Determine the largest value in a range or array.',
        'Multiply two numbers together.',
        'Apply formatting to a cell.',
        'Find the average of a range.'
      ],
      'correctAnswerIndex': 0,
    },
  ];

  List<Map<String, dynamic>> index11 = [
    {
      'question': 'The IF function in Excel allows you to:',
      'answers': [
        'Evaluate multiple conditions using the AND operator.',
        'Evaluate multiple conditions using the OR operator.',
        'Perform mathematical calculations.',
        'Create charts and graphs.'
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question':
          'Which logical operator is used to combine multiple conditions using the IF function?',
      'answers': ['AND', 'OR', 'NOT', 'XOR'],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'The formula "=IF(AND(A1>10, B1<20), "Yes", "No")" will return "Yes" if:',
      'answers': [
        'The value in cell A1 is greater than 10 and the value in cell B1 is less than 20.',
        'The value in cell A1 is less than or equal to 10 or the value in cell B1 is greater than or equal to 20.',
        'Either the value in cell A1 is greater than 10 or the value in cell B1 is less than 20.',
        'Neither the value in cell A1 is greater than 10 nor the value in cell B1 is less than 20.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'The formula "=IF(OR(A1>10, B1<20), "Yes", "No")" will return "Yes" if:',
      'answers': [
        'The value in cell A1 is greater than 10 or the value in cell B1 is less than 20.',
        'The value in cell A1 is less than or equal to 10 and the value in cell B1 is greater than or equal to 20.',
        'Both the value in cell A1 is greater than 10 and the value in cell B1 is less than 20.',
        'Neither the value in cell A1 is greater than 10 nor the value in cell B1 is less than 20.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'The IF function in Excel can be nested within another IF function to:',
      'answers': [
        'Evaluate multiple conditions using the AND operator.',
        'Evaluate multiple conditions using the OR operator.',
        'Perform mathematical calculations.',
        'Create charts and graphs.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'In Excel, the formula "=IF(A1>10, IF(B1<20, "Yes", "No"), "N/A")" will return "Yes" if:',
      'answers': [
        'The value in cell A1 is greater than 10 and the value in cell B1 is less than 20.',
        'The value in cell A1 is less than or equal to 10 or the value in cell B1 is greater than or equal to 20.',
        'Either the value in cell A1 is greater than 10 or the value in cell B1 is less than 20.',
        'Neither the value in cell A1 is greater than 10 nor the value in cell B1 is less than 20.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'The IF function in Excel is used for:',
      'answers': [
        'Applying conditional formatting to cells.',
        'Sorting and filtering data.',
        'Performing mathematical calculations.',
        'Checking whether a condition is met and returning different values based on the result.'
      ],
      'correctAnswerIndex': 3,
    },
    {
      'question':
          'The formula "=IF(AND(A1="Red", B1="Blue"), "Purple", "Other")" will return "Purple" if:',
      'answers': [
        'The value in cell A1 is "Red" and the value in cell B1 is "Blue".',
        'The value in cell A1 is not "Red" or the value in cell B1 is not "Blue".',
        'Either the value in cell A1 is "Red" or the value in cell B1 is "Blue".',
        'Neither the value in cell A1 is "Red" nor the value in cell B1 is "Blue".'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'The formula "=IF(OR(A1="Yes", B1="Yes"), "True", "False")" will return "True" if:',
      'answers': [
        'The value in cell A1 is "Yes" or the value in cell B1 is "Yes".',
        'The value in cell A1 is not "Yes" and the value in cell B1 is not "Yes".',
        'Both the value in cell A1 is "Yes" and the value in cell B1 is "Yes".',
        'Neither the value in cell A1 is "Yes" nor the value in cell B1 is "Yes".'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'The IF function in Excel can be used to perform calculations based on conditions and return:',
      'answers': [
        'Text or numerical values.',
        'Only text values.',
        'Only numerical values.',
        'Logical values (TRUE/FALSE).'
      ],
      'correctAnswerIndex': 0,
    },
  ];
  List<Map<String, dynamic>> index4 = [
    {
      'question': 'What does the MATCH function in Excel do?',
      'answers': [
        'It looks up a value in a specified range and returns its relative position.',
        'It retrieves the value from a cell in a different worksheet.',
        'It calculates the sum of a range of values.',
        'It finds the average of a specified range of cells.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which of the following statements is true about the INDEX function?',
      'answers': [
        'It returns the value of a cell in a different worksheet without specifying the worksheet name.',
        'It returns the reference of a cell based on its row and column number in a range.',
        'It only works with numeric values and cannot handle text data.',
        'It automatically sorts the data in ascending order before returning the result.'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question':
          'When using the MATCH function, what happens if the lookup value is not found in the search range?',
      'answers': [
        'Excel returns an error.',
        'Excel automatically inserts the value in the search range.',
        'Excel returns the value closest to the lookup value.',
        'Excel returns the value of the last item in the search range.'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What is the syntax for the MATCH function in Excel?',
      'answers': [
        'MATCH(lookup_value, lookup_array, [match_type])',
        'MATCH([match_type], lookup_value, lookup_array)',
        'MATCH(lookup_array, [match_type], lookup_value)',
        'MATCH([match_type], lookup_array, lookup_value)'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'Which match_type argument should be used to find an exact match in the search range?',
      'answers': ['0', '1', '-1', '2'],
      'correctAnswerIndex': 0,
    },
    {
      'question':
          'In the INDEX function, what is the purpose of the "row_num" argument?',
      'answers': [
        'To specify the column number where the result is located.',
        'To specify the row number where the result is located.',
        'To define the range where the value should be looked up.',
        'To set the data type of the result.'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question':
          'Which combination of functions can be used to find a value in a two-dimensional table in Excel?',
      'answers': [
        'VLOOKUP and HLOOKUP',
        'INDEX and MATCH',
        'SUMIF and COUNTIF',
        'MAX and MIN'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question':
          'The MATCH function in Excel can search for a lookup value in:',
      'answers': [
        'Rows only',
        'Columns only',
        'Both rows and columns',
        'Diagonals only'
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question':
          'What is the purpose of using the INDEX function instead of directly referencing a cell in Excel?',
      'answers': [
        'INDEX function automatically formats the cell result.',
        'INDEX function allows you to retrieve values from a range based on row and column numbers.',
        'INDEX function is faster in performance compared to direct cell references.',
        'INDEX function can handle a larger range of data types.'
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question':
          'Which of the following is NOT a limitation of the INDEX and MATCH combination in Excel?',
      'answers': [
        'INDEX and MATCH can only be used with numerical data.',
        'INDEX and MATCH may become slow with large datasets.',
        'INDEX and MATCH require two separate functions to achieve the lookup.',
        'INDEX and MATCH can be more complex to set up than VLOOKUP.'
      ],
      'correctAnswerIndex': 0,
    },
  ];
  List<Map<String, dynamic>> index13 = [
    {
      'question':
          'Which of the following formulas can be used to convert text to mixed case (both upper and lower case) in Excel?',
      'options': [
        'a) =MIXEDCASE(A1)',
        'b) =PROPER(A1)',
        'c) =MIXED(A1)',
        'd) =MID(A1)'
      ],
      'answer': 'b'
    },
    {
      'question': 'The TODAY() function in Excel is used to:',
      'options': [
        'a) Return the current date and time.',
        'b) Return the current date in the format YYYY-MM-DD.',
        'c) Return the current date in the format DD-MM-YYYY.',
        'd) Return the current date without any formatting.'
      ],
      'answer': 'b'
    },
    {
      'question':
          'To extract the year from a date in cell A1, which formula should be used in Excel?',
      'options': [
        'a) =YEAR(A1)',
        'b) =DATE(YEAR(A1))',
        'c) =EXTRACT_YEAR(A1)',
        'd) =A1.YEAR()'
      ],
      'answer': 'a'
    },
    {
      'question':
          'Which of the following Excel functions is used to add a specified number of months to a date?',
      'options': ['a) DATEADD', 'b) ADDMONTHS', 'c) EDATE', 'd) DATEPLUS'],
      'answer': 'c'
    },
    {
      'question': 'The DATEDIF function in Excel is used to:',
      'options': [
        'a) Calculate the difference between two dates in years, months, or days.',
        'b) Determine if two dates are equal.',
        'c) Find the total number of days in a given date range.',
        'd) Display the date in a specific format.'
      ],
      'answer': 'a'
    },
    {
      'question':
          'To convert the date "25/07/2023" to the text "July 25, 2023," which formula should be used in Excel?',
      'options': [
        'a) =TEXT(A1, "mm/dd/yyyy")',
        'b) =TEXT(A1, "dd-mm-yyyy")',
        'c) =TEXT(A1, "mmm dd, yyyy")',
        'd) =TEXT(A1, "mmmm dd, yyyy")'
      ],
      'answer': 'd'
    },
    {
      'question': 'The NETWORKDAYS function in Excel is used to:',
      'options': [
        'a) Calculate the number of working days between two dates, excluding weekends.',
        'b) Calculate the total number of days between two dates, including weekends.',
        'c) Calculate the difference between two dates in network weeks.',
        'd) Determine if a date falls on a network day or not.'
      ],
      'answer': 'a'
    },
    {
      'question': 'How can you add 5 years to a date in cell A1 in Excel?',
      'options': [
        'a) =A1 + 5',
        'b) =DATE(YEAR(A1) + 5, MONTH(A1), DAY(A1))',
        'c) =EDATE(A1, 5)',
        'd) =YEAR(A1) + 5'
      ],
      'answer': 'b'
    },
    {
      'question': 'The WEEKDAY function in Excel is used to:',
      'options': [
        'a) Convert a date into a day of the week.',
        'b) Calculate the number of weekdays between two dates.',
        'c) Determine the week number of a given date.',
        'd) Convert a date into a numerical representation of the day of the week.'
      ],
      'answer': 'd'
    },
    {
      'question':
          'To display the current time in cell A1 in Excel, which formula should be used?',
      'options': [
        'a) =TIME()',
        'b) =NOW()',
        'c) =CURRENT_TIME()',
        'd) =TIMEVALUE(NOW())'
      ],
      'answer': 'b'
    }
  ];

  List<Map<String, dynamic>> index14 = [
    {
      'question': 'The function "CONCAT" in Excel is used to:',
      'options': {
        'A':
            'Combine two or more text strings into one, using a specified delimiter.',
        'B': 'Convert text to uppercase letters.',
        'C':
            'Count the total number of characters in a text string, including spaces.',
        'D':
            'Replace text in a cell with new text, based on a specified occurrence.'
      },
      'answer': 'A'
    },
    {
      'question': 'The function "RIGHT" in Excel is used to:',
      'options': {
        'A': 'Convert text to a number.',
        'B':
            'Extract a specific number of characters from the beginning of a text string.',
        'C': 'Convert text to uppercase letters.',
        'D': 'Capitalize the first letter of each word in a text string.'
      },
      'answer': 'B'
    },
    {
      'question': 'The function "LENB" in Excel is used to:',
      'options': {
        'A':
            'Count the total number of characters in a text string, excluding spaces.',
        'B': 'Convert text to uppercase letters.',
        'C': 'Count the total number of bytes used in a text string.',
        'D':
            'Replace text in a cell with new text, based on a specified occurrence.'
      },
      'answer': 'C'
    },
    {
      'question': 'The function "TRIM" in Excel is used to:',
      'options': {
        'A': 'Convert text to uppercase letters.',
        'B':
            'Count the total number of characters in a text string, including spaces.',
        'C':
            'Remove excess spaces at the beginning, end, and between words in a text string.',
        'D': 'Convert text to lowercase letters.'
      },
      'answer': 'C'
    },
    {
      'question': 'The function "UPPERB" in Excel is used to:',
      'options': {
        'A': 'Convert text to uppercase letters.',
        'B':
            'Count the total number of characters in a text string, including spaces.',
        'C': 'Convert text to a date.',
        'D': 'Convert text to a number.'
      },
      'answer': 'A'
    },
    {
      'question': 'The function "FIND" in Excel is used to:',
      'options': {
        'A': 'Convert text to a number.',
        'B':
            'Extract a specific number of characters from the middle of a text string.',
        'C':
            'Find the position of a specific character or substring within a text string.',
        'D':
            'Replace text in a cell with new text, based on a specified occurrence.'
      },
      'answer': 'C'
    },
    {
      'question': 'The function "SUBTOTAL" in Excel is used to:',
      'options': {
        'A': 'Concatenate text strings with a specified delimiter.',
        'B':
            'Count the total number of characters in a text string, including spaces.',
        'C':
            'Calculate a subtotal of a range using a specified aggregation function.',
        'D': 'Convert text to uppercase letters.'
      },
      'answer': 'C'
    },
    {
      'question': 'The function "REPT" in Excel is used to:',
      'options': {
        'A': 'Repeat a text string a specified number of times.',
        'B':
            'Replace text in a cell with new text, based on a specified occurrence.',
        'C':
            'Count the total number of characters in a text string, including spaces.',
        'D': 'Convert text to a date.'
      },
      'answer': 'A'
    },
    {
      'question': 'The function "SEARCHB" in Excel is used to:',
      'options': {
        'A': 'Convert text to a number.',
        'B': 'Convert text to uppercase letters.',
        'C':
            'Find the position of a specific character or substring within a text string, counting bytes.',
        'D':
            'Extract a specific number of characters from the beginning of a text string.'
      },
      'answer': 'C'
    },
    {
      'question': 'The function "LEFTB" in Excel is used to:',
      'options': {
        'A': 'Convert text to a number.',
        'B': 'Count the total number of bytes used in a text string.',
        'C':
            'Extract a specific number of characters from the beginning of a text string, counting bytes.',
        'D': 'Convert text to a date.'
      },
      'answer': 'C'
    }
  ];
  List<Map<String, dynamic>> index5 = [
    {
      "question": "What is Power Pivot in Excel?",
      "answers": [
        {
          "option": "a",
          "text":
              "A data analysis tool that allows you to create pivot tables and charts."
        },
        {
          "option": "b",
          "text":
              "An add-in that extends the functionality of Excel to work with large datasets."
        },
        {
          "option": "c",
          "text":
              "A feature that automatically generates formulas based on cell references."
        },
        {
          "option": "d",
          "text":
              "A data visualization tool for creating interactive dashboards."
        }
      ],
      "correctAnswer": "b"
    },
    {
      "question": "Power Pivot in Excel is designed to handle:",
      "answers": [
        {
          "option": "a",
          "text": "Simple spreadsheets with a few hundred rows of data."
        },
        {
          "option": "b",
          "text": "Datasets with up to a few thousand rows of data."
        },
        {
          "option": "c",
          "text": "Large datasets with millions of rows of data."
        },
        {"option": "d", "text": "Text-based data only, not numerical data."}
      ],
      "correctAnswer": "c"
    },
    {
      "question":
          "Which language is used to create custom calculations and measures in Power Pivot?",
      "answers": [
        {"option": "a", "text": "Visual Basic for Applications (VBA)"},
        {"option": "b", "text": "Structured Query Language (SQL)"},
        {"option": "c", "text": "Data Analysis Expressions (DAX)"},
        {"option": "d", "text": "Hypertext Markup Language (HTML)"}
      ],
      "correctAnswer": "c"
    },
    {
      "question":
          "Power Pivot allows you to combine data from multiple sources using:",
      "answers": [
        {"option": "a", "text": "VLOOKUP function"},
        {"option": "b", "text": "INDEX and MATCH functions"},
        {"option": "c", "text": "Power Query"},
        {"option": "d", "text": "PivotTables only"}
      ],
      "correctAnswer": "c"
    },
    {
      "question": "What is the primary benefit of using Power Pivot in Excel?",
      "answers": [
        {"option": "a", "text": "It makes your Excel spreadsheets run faster."},
        {
          "option": "b",
          "text": "It automatically generates charts based on data."
        },
        {
          "option": "c",
          "text":
              "It can handle much larger datasets than regular Excel worksheets."
        },
        {
          "option": "d",
          "text": "It allows you to create macros to automate tasks."
        }
      ],
      "correctAnswer": "c"
    },
    {
      "question":
          "Which of the following is a key feature of Power Pivot in Excel?",
      "answers": [
        {"option": "a", "text": "Data validation"},
        {"option": "b", "text": "Data sorting"},
        {"option": "c", "text": "Data modeling"},
        {"option": "d", "text": "Data filtering"}
      ],
      "correctAnswer": "c"
    },
    {
      "question":
          "Power Pivot in Excel enables you to create relationships between tables based on:",
      "answers": [
        {"option": "a", "text": "Cell references"},
        {"option": "b", "text": "Formatting styles"},
        {"option": "c", "text": "Common fields or columns"},
        {"option": "d", "text": "Conditional formatting rules"}
      ],
      "correctAnswer": "c"
    },
    {
      "question": "How is data stored and managed in Power Pivot in Excel?",
      "answers": [
        {"option": "a", "text": "In separate XML files"},
        {"option": "b", "text": "In a relational database"},
        {"option": "c", "text": "In a cloud-based server"},
        {"option": "d", "text": "In the regular Excel workbook"}
      ],
      "correctAnswer": "b"
    },
    {
      "question":
          "Which function is used in Power Pivot to aggregate data and calculate values over large datasets?",
      "answers": [
        {"option": "a", "text": "SUM"},
        {"option": "b", "text": "COUNT"},
        {"option": "c", "text": "AVERAGE"},
        {"option": "d", "text": "DAX"}
      ],
      "correctAnswer": "d"
    },
  ];
  List<Map<String, dynamic>> index6 = [
    {
      'question':
          'Which Excel function is used to combine two or more text strings into one?',
      'options': {
        'A': 'CONCATENATE',
        'B': 'TEXTJOIN',
        'C': 'COMBINE',
        'D': 'MERGE'
      },
      'answer': 'A' // Example answer; adjust as needed
    },
    {
      'question': 'The function "LEN" in Excel is used to:',
      'options': {
        'A':
            'Count the total number of characters in a text string, including spaces.',
        'B': 'Convert text to lowercase.',
        'C': 'Find and replace specific text in a cell.',
        'D': 'Extract a specified number of characters from a text string.'
      },
      'answer': 'A'
    },
    {
      'question':
          'Which Excel function is used to convert text to uppercase letters?',
      'options': {'A': 'UPPER', 'B': 'PROPER', 'C': 'LOWER', 'D': 'CAPS'},
      'answer': 'A'
    },
    {
      'question': 'The function "MID" in Excel is used to:',
      'options': {
        'A':
            'Extract a specific number of characters from the beginning of a text string.',
        'B':
            'Extract a specific number of characters from the end of a text string.',
        'C':
            'Extract a specific number of characters from the middle of a text string.',
        'D': 'Combine multiple text strings into one.'
      },
      'answer': 'C'
    },
    {
      'question': 'The function "SUBSTITUTE" in Excel is used to:',
      'options': {
        'A':
            'Replace text in a cell with new text, based on a specified occurrence.',
        'B': 'Convert text to a number.',
        'C': 'Convert text to a date.',
        'D': 'Combine multiple text strings into one.'
      },
      'answer': 'A'
    },
    {
      'question': 'The function "PROPER" in Excel is used to:',
      'options': {
        'A': 'Convert text to uppercase letters.',
        'B': 'Convert text to lowercase letters.',
        'C': 'Capitalize the first letter of each word in a text string.',
        'D':
            'Count the total number of characters in a text string, excluding spaces.'
      },
      'answer': 'C'
    },
    {
      'question':
          'Which Excel function is used to find the position of a specific character or substring within a text string?',
      'options': {'A': 'FIND', 'B': 'SEARCH', 'C': 'LOCATE', 'D': 'INDEX'},
      'answer': 'A'
    },
    {
      'question': 'The function "LEFT" in Excel is used to:',
      'options': {
        'A':
            'Extract a specific number of characters from the beginning of a text string.',
        'B':
            'Extract a specific number of characters from the end of a text string.',
        'C':
            'Extract a specific number of characters from the middle of a text string.',
        'D': 'Convert text to lowercase letters.'
      },
      'answer': 'A'
    },
    {
      'question': 'The function "REPLACE" in Excel is used to:',
      'options': {
        'A':
            'Replace text in a cell with new text, based on a specified occurrence.',
        'B': 'Convert text to uppercase letters.',
        'C': 'Convert text to a number.',
        'D': 'Extract a specific number of characters from a text string.'
      },
      'answer': 'A'
    },
    {
      'question': 'The function "TEXTJOIN" in Excel is used to:',
      'options': {
        'A': 'Combine text strings with a specified delimiter.',
        'B': 'Convert text to a date.',
        'C': 'Convert text to a number.',
        'D': 'Capitalize the first letter of each word in a text string.'
      },
      'answer': 'A'
    }
  ];
  List<Map<String, dynamic>> index15 = [
    {
      'question': 'The VLOOKUP function in Excel is used to:',
      'options': {
        'A': 'Retrieve data from a vertical column in another table.',
        'B': 'Retrieve data from a horizontal row in another table.',
        'C': 'Create a lookup table for future reference.',
        'D': 'Calculate the average of a range of values.'
      },
      'answer': 'A' // Example answer; adjust as needed
    },
    {
      'question': 'The HLOOKUP function in Excel is used to:',
      'options': {
        'A': 'Retrieve data from a vertical column in another table.',
        'B': 'Retrieve data from a horizontal row in another table.',
        'C': 'Create a lookup table for future reference.',
        'D': 'Calculate the sum of a range of values.'
      },
      'answer': 'B'
    },
    {
      'question':
          'Which of the following is the correct syntax for the VLOOKUP function?',
      'options': {
        'A': '=VLOOKUP(lookup_value, table_array, col_index_num, range_lookup)',
        'B': '=VLOOKUP(table_array, lookup_value, col_index_num, range_lookup)',
        'C': '=VLOOKUP(col_index_num, table_array, lookup_value, range_lookup)',
        'D': '=VLOOKUP(range_lookup, lookup_value, table_array, col_index_num)'
      },
      'answer': 'A'
    },
    {
      'question':
          'The range_lookup parameter in the VLOOKUP function allows you to:',
      'options': {
        'A': 'Search for an exact match only.',
        'B': 'Search for an approximate match only.',
        'C': 'Search for both exact and approximate matches.',
        'D': 'Determine the size of the lookup table.'
      },
      'answer': 'B'
    },
    {
      'question': 'The HLOOKUP function searches for data:',
      'options': {
        'A': 'Vertically in a specified range.',
        'B': 'Horizontally in a specified range.',
        'C': 'Diagonally in a specified range.',
        'D': 'Both vertically and horizontally in a specified range.'
      },
      'answer': 'B'
    },
    {
      'question':
          'The col_index_num parameter in the VLOOKUP function specifies:',
      'options': {
        'A': 'The lookup value to be searched in the table array.',
        'B':
            'The column number in the table array from which to return the result.',
        'C':
            'The row number in the table array from which to return the result.',
        'D': 'The range of values to be considered for the lookup.'
      },
      'answer': 'B'
    },
    {
      'question':
          'In VLOOKUP, if the range_lookup parameter is set to TRUE, what does it mean?',
      'options': {
        'A': 'It will search for an exact match.',
        'B': 'It will search for an approximate match.',
        'C': 'It will return the closest match to the lookup value.',
        'D': 'It will return the last match found.'
      },
      'answer': 'B'
    },
    {
      'question':
          'Which function is best suited for finding a student\'s score in a grade table based on their name?',
      'options': {'A': 'VLOOKUP', 'B': 'HLOOKUP', 'C': 'INDEX', 'D': 'MATCH'},
      'answer': 'A'
    },
    {
      'question':
          'Which function allows you to perform a two-dimensional lookup (both rows and columns)?',
      'options': {'A': 'VLOOKUP', 'B': 'HLOOKUP', 'C': 'INDEX', 'D': 'MATCH'},
      'answer': 'C'
    },
    {
      'question':
          'In VLOOKUP, if the range_lookup parameter is omitted or set to FALSE, what does it mean?',
      'options': {
        'A': 'It will search for an exact match.',
        'B': 'It will search for an approximate match.',
        'C': 'It will return an error if the lookup value is not found.',
        'D': 'It will return the last match found.'
      },
      'answer': 'A'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appBar(),
              sizeBoxHeight(25),
              if (widget.indexquetions == 0 || widget.indexquetions == 1)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questions.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = questions[questionIndex];
                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 3)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index3.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index3[questionIndex];
                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 11)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index11.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index11[questionIndex];
                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 14)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index14.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index14[questionIndex];
                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 5)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index5.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index5[questionIndex];
                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 6)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index6.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index6[questionIndex];
                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 6)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index15.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index15[questionIndex];

                      return questionData(questionIndex, question);
                    }),
              if (widget.indexquetions == 1 &&
                  widget.indexquetions == 3 &&
                  widget.indexquetions == 2 &&
                  widget.indexquetions == 4 &&
                  widget.indexquetions == 7 &&
                  widget.indexquetions == 8 &&
                  widget.indexquetions == 10 &&
                  widget.indexquetions == 14)
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: index15.length,
                    itemBuilder: (BuildContext context, int questionIndex) {
                      final question = index15[questionIndex];

                      return questionData(questionIndex, question);
                    }),
              sizeBoxHeight(25),
              sizeBoxHeight(25),
              endButton(),
              sizeBoxHeight(25),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            await widget.onRefresh;
            Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                return CourseDetailsScreen();
              },
            ));
          },
          child: Image.asset('${AppImages.courseImages}backarrow.png',
              height: 13.h),
        ),
        AppText(
          text: 'Questions and Answers',
          color: AppColor.blackcolor,
          fontWeight: FontWeight.w600,
          fontsize: 13.sp,
        ),
        Image.asset('${AppImages.courseImages}backarrow.png',
            height: 13.h, color: Colors.transparent),
      ],
    );
  }

  Widget questionData(questionIndex, question) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 41.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.grey3color,
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      text: '${questionIndex + 1}. ${question['question']}',
                      color: AppColor.blackcolor,
                      fontWeight: FontWeight.w400,
                      fontsize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (question['answers'] as List<String>)
                .asMap()
                .entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Material(
                          type: MaterialType.canvas,
                          shadowColor: AppColor.grey2color,
                          child: Checkbox(
                            visualDensity: VisualDensity.compact,
                            activeColor: AppColor.blackcolor,
                            value: selectedAnswerIndexes[questionIndex] ==
                                entry.key,
                            onChanged: (value) {
                              setState(() {
                                selectedAnswerIndexes[questionIndex] =
                                    value! ? entry.key : -1;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              color: selectedAnswerIndexes[questionIndex] ==
                                      entry.key
                                  ? AppColor.blackcolor
                                  : AppColor.greycolor,
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget endButton() {
    return GestureDetector(
      onTap: () async {
           AppPreference().setBool(PreferencesKey.index1, true);
        // Check if all questions have been answered
        bool allAnswered = !selectedAnswerIndexes.contains(-1);
        print(allAnswered!);
        if (widget.indexquetions == 0) {
          AppPreference().setBool(PreferencesKey.index1, true);
        } else if (widget.indexquetions == 1) {
          AppPreference().setBool(PreferencesKey.index2, true);
        } else if (widget.indexquetions == 2) {
          AppPreference().setBool(PreferencesKey.index3, true);
        } else if (widget.indexquetions == 3) {
          AppPreference().setBool(PreferencesKey.index4, true);
        } else if (widget.indexquetions == 4) {
          AppPreference().setBool(PreferencesKey.index5, true);
        } else if (widget.indexquetions == 5) {
          AppPreference().setBool(PreferencesKey.index6, true);
        } else if (widget.indexquetions == 6) {
          AppPreference().setBool(PreferencesKey.index7, true);
        } else if (widget.indexquetions == 7) {
          AppPreference().setBool(PreferencesKey.index8, true);
        } else if (widget.indexquetions == 8) {
          AppPreference().setBool(PreferencesKey.index8, true);
        } else if (widget.indexquetions == 9) {
          AppPreference().setBool(PreferencesKey.index8, true);
        } else if (widget.indexquetions == 10) {
          AppPreference().setBool(PreferencesKey.index9, true);
        } else if (widget.indexquetions == 11) {
          AppPreference().setBool(PreferencesKey.index10, true);
        } else if (widget.indexquetions == 12) {
          AppPreference().setBool(PreferencesKey.index11, true);
        } else if (widget.indexquetions == 12) {
          AppPreference().setBool(PreferencesKey.index11, true);
        } else if (widget.indexquetions == 13) {
          AppPreference().setBool(PreferencesKey.index12, true);
        } else if (widget.indexquetions == 14) {
          AppPreference().setBool(PreferencesKey.index13, true);
        }

        if (allAnswered) {
          // Save preference or perform your action
          await AppPreference().setBool(PreferencesKey.index1, true);
          print(widget.indexquetions);
          // void handleIndexPreferencee() async {
          //   switch (widget.indexquetions) {
          //     case 0:
          //       await AppPreference().setBool(PreferencesKey.index1, true);
          //       break;
          //     case 1:
          //       await AppPreference().setBool(PreferencesKey.index2, true);
          //       break;
          //     case 2:
          //       await AppPreference().setBool(PreferencesKey.index3, true);
          //       break;
          //     case 3:
          //       await AppPreference().setBool(PreferencesKey.index4, true);
          //       break;
          //     case 4:
          //       await AppPreference().setBool(PreferencesKey.index5, true);
          //       break;
          //     case 5:
          //       await AppPreference().setBool(PreferencesKey.index6, true);
          //       break;
          //     case 6:
          //       await AppPreference().setBool(PreferencesKey.index7, true);
          //       break;
          //     case 7:
          //       await AppPreference().setBool(PreferencesKey.index8, true);
          //       break;
          //     case 8:
          //       await AppPreference().setBool(PreferencesKey.index9, true);
          //       break;
          //     case 9:
          //       await AppPreference().setBool(PreferencesKey.index10, true);
          //       break;
          //     case 10:
          //       await AppPreference().setBool(PreferencesKey.index11, true);
          //       break;
          //     case 11:
          //       await AppPreference().setBool(PreferencesKey.index12, true);
          //       break;
          //     case 12:
          //       await AppPreference().setBool(PreferencesKey.index13, true);
          //       break;
          //     case 13:
          //       await AppPreference().setBool(PreferencesKey.index14, true);
          //       break;

          //     default:
          //       // Handle any cases that don't match the above values
          //       break;
          //   }
          // }

          void handleIndexPreference() async {}
         // await AppPreference().initialAppPreference();
          await widget.onRefresh;
          // Navigator.pushReplacement(context, CupertinoPageRoute(
          //   builder: (context) {
          //     return CourseDetailsScreen();
          //   },
          // ));
        } else {
          print(allAnswered!);
          // Show a message or prompt indicating that not all questions are answered
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please answer all questions before submitting.'),
            ),
          );
        }

        print(widget.indexquetions);
      },
      child: Container(
        height: 48,
        width: 205,
        decoration: BoxDecoration(
          color: AppColor.blackcolor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: AppText(
            text: 'End Exam',
            color: AppColor.whitecolor,
            fontWeight: FontWeight.w600,
            fontsize: 15.sp,
          ),
        ),
      ),
    );
  }
}
