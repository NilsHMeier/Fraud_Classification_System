# Fraud_Classification_System
This repository provides the code belonging to the exam in the module "Information systems in marketing" in winter term 2020/21 at Leuphana University Lüneburg.

## Project Description
A food retailer wants to optimize his self-scanning system that allows customers to scan their items using a handheld mobile scanner. Some customers commit fraud
by not scanning all of the items in their cart. The food retailer wants to identify those frauds by targeted follow-up checks. The challenge is to keep the number
of checks as low as possible to avoid unnecessary added expense as well as to avoid affronting innocent customers due to false accusations. For this purpose the
retailer has collected historical data (see description on last page).

The objective is to develop a software system, which uses the historical data to reliably classify scans as fraudulent or not fraudulent.

## Project Task
Develop a fraud detection system (see description above) which optimizes the balanced accuracy. The system has to be developed with the R package caret. 
Please prefer algorithms which have been presented in the lectures. The training data is contained in the file train.txt encoded in Windows-1252 (ANSI). 
The system shall be able to process unseen records provided in a file unseen.txt containing the same attributes (with the exception of target attribute 
in the last column) in the same order and encoding as in the file train.txt and containing about the same percentage of frauds. The system output shall 
be a text file classified.txt containing all records of the file unseen.txt (all rows and columns in the same order) completed by the predicted value of 
the target attribute.

## Description of data
**trustLevel:** A customer’s individual trust level. 6: Highest trustworthiness - Value range: 1, 2, 3, 4, 5, 6

**totalScanTimeSeconds:** Total time in seconds between the first and last product scanned - Value range: Positive whole number

**grandTotal:** Grand total of products scanned - Value Range: Positive decimal number with maximum two decimal places

**lineItemVoids:** Number of voided scans - Value range: Positive whole number

**scansWithoutRegistration:** Number of attempts to activate the scanner without actually scanning anything - Value range: Positive whole number or 0

quantityModifications:** Number of modified quantities for one of the scanned products - Value range: Positive whole number or 0

**scannedLineItemsPerSecond:** Average number of scanned products per second - Value range: Positive decimal number

**valuePerSecond:** Average total value of scanned products per second - Value range: Positive decimal number

**lineItemVoidsPerPosition:** Average number of item voids per total number of all scanned and not cancelled products - Value range: Positive decimal number

**fraud:** Classification as fraud (1) or not fraud (0) - Value range: 0,1
