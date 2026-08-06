# Pizza Sales SQL Analysis Project 

##  Project Overview
The **Pizza Sales SQL Project** is designed to analyze pizza sales data using SQL queries and database management techniques. The project focuses on understanding customer ordering patterns, sales performance, and revenue generation. Various SQL concepts such as JOINS, Aggregate Functions, GROUP BY, and Window Functions are used to extract meaningful insights from the data, supporting better decision-making for restaurant management.

---

##  Database Architecture
The analysis is executed across four interconnected tables, mapping transactional data directly to product attributes:
* **`orders`**: Logs core transaction endpoints (`order_id`, `date`, `time`).
* **`order_details`**: Captures granular line items within each transaction (`order_details_id`, `order_id`, `pizza_id`, `quantity`).
* **`pizzas`**: Functions as the product master list tracking pricing metrics (`pizza_id`, `pizza_type_id`, `size`, `price`).
* **`pizza_types`**: Stores high-level product metadata and structural grouping (`pizza_type_id`, `name`, `category`, `ingredients`).

---

##  Key Business Insights & Objectives

### 1. Financial Performance Analysis
* **Total Dataset Volume**: Processed annual dataset representing 21,350 unique rows.
* **Total Throughput**: A total of **49,574** pizzas were ordered throughout the year.
* **Average Order Value Metrics**: The average number of pizzas ordered per order stands at **2 pizzas**.
* **Top Spending Transactions**: The top 3 orders with the highest spend are Order ID `18845` ($444.20), Order ID `10760` ($417.15), and Order ID `1096` ($285.15).

### 2. Operational Efficiency Mapping
* **Busiest Weekday**: **Friday** is the peak day for order placement, capturing **3,538 total orders**.
* **Peak Rush Hours**: Order volumes sharply peak at lunch hour (**12:00 PM** with 2,520 orders) and dinner rush hour (**6:00 PM / 18:00** with 2,399 orders).
* **Operational Window**: Opening timestamps begin from **11:00 AM** blocks, stretching to late-night closing with the absolute latest order placed at **11:05:52 PM (23:05:52)**.

### 3. Menu & Portfolio Optimization
* **Revenue Driver Category**: The **Classic** pizza category acts as the primary financial engine, capturing the maximum revenue share of **$220,053.10 (26.91%)**.
* **Category Contribution Breakdown**:
  * **Classic**: 26.91% ($220,053.10)
  * **Supreme**: 25.46% ($208,197.00)
  * **Chicken**: 23.96% ($195,919.50)
  * **Veggie**: 23.68% ($193,690.45)
* **Top 5 Most Popular Pizzas (by Quantity Sold)**:
  1. The Classic Deluxe Pizza (2,453 sold)
  2. The Barbecue Chicken Pizza (2,432 sold)
  3. The Hawaiian Pizza (2,422 sold)
  4. The Pepperoni Pizza (2,418 sold)
  5. The Thai Chicken Pizza (2,371 sold)
* **Underperforming Menu Items**: **The Brie Carre Pizza** was identified as the least ordered pizza type, generating only **490 total unit sales**.

---

##  Project Repository Directories & Navigation

All backend code scripts and frontend visualization reports are organized into dedicated file paths below:

*  **[SQL Script File](./pizza_queries.sql)**: Contains the complete development script engine for all 18 business case studies—including advanced multi-table relational joins, data aggregation grouping matrices, and complex analytical window functions (`LAG`, `LEAD`, `DENSE_RANK`, running totals).
*  **[Executive Presentation Report](./Pizza%20sales%20report.pptx)**: Contains the complete stakeholder slide presentation report mapping visual trend charts, performance indicators, and execution matrices.
