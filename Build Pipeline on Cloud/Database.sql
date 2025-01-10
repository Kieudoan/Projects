
-- Account

DROP TABLE IF EXISTS Account;
CREATE TABLE Account (
    account_ID VARCHAR(10) NOT NULL,
    registration_ID VARCHAR(10) NOT NULL,
    fName VARCHAR(20) NOT NULL,
    lName VARCHAR(40) NOT NULL,
    email VARCHAR(320) NOT NULL,
    cell_Num CHAR(12) NULL,
    logon_ID VARCHAR(20) NOT NULL,
    [password] VARCHAR(32) NOT NULL,
    create_Date DATE NOT NULL,
    account_Type CHAR(1) NOT NULL,
    CONSTRAINT account_Type CHECK (account_Type IN ('P', 'B')),
    CONSTRAINT account_pk PRIMARY KEY (account_ID)
);

-- Item
DROP TABLE IF EXISTS Item;
CREATE TABLE Item (
    item_ID VARCHAR(10) NOT NULL,
    sku CHAR(8) NOT NULL,
    [name] VARCHAR(40) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    item_desc VARCHAR(100) NULL,
    category VARCHAR(10) NULL,
    stock INT NOT NULL,
    item_star INT NULL,
    item_sizes VARCHAR(5) NULL,
    color VARCHAR(20) NULL,
    CONSTRAINT item_pk PRIMARY KEY (item_ID)
);

-- CARD
DROP TABLE IF EXISTS CARD;
CREATE TABLE CARD (
    card_number VARCHAR(16) NOT NULL,
    cc_name VARCHAR(40) NOT NULL,
    pin CHAR(4) NOT NULL,
    b_street VARCHAR(40),
    b_city VARCHAR(20),
    b_state CHAR(2),
    b_zip CHAR(10),
    CONSTRAINT Card_PK PRIMARY KEY (card_number)
);

-- Customer_Order
DROP TABLE IF EXISTS Customer_Order;
CREATE TABLE Customer_Order (
    order_ID VARCHAR(10) NOT NULL,
    account_ID VARCHAR(10) NOT NULL,
    s_street VARCHAR(40) NULL,
    s_City VARCHAR(20) NULL,
    s_State CHAR(2) NOT NULL,
    s_Zip CHAR(10) NULL,
    order_date DATE NULL,
    receiver_name VARCHAR(40) NOT NULL,
    delivery_date DATE NULL,
    dispatch_date DATE NULL,
    CONSTRAINT Customer_Order_pk PRIMARY KEY (order_ID),
    CONSTRAINT account_order FOREIGN KEY (account_ID) REFERENCES Account (account_ID)
);

-- Order_Item
DROP TABLE IF EXISTS Order_Item;
CREATE TABLE Order_Item (
    order_ID VARCHAR(10) NOT NULL,
    order_item_ID VARCHAR(10) NOT NULL,
    item_ID VARCHAR(10) NOT NULL,
    discounted_price DECIMAL(12, 2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT order_item_pk PRIMARY KEY (order_ID, order_item_ID),
    CONSTRAINT order_id FOREIGN KEY (order_ID) REFERENCES Customer_Order (order_ID),
    CONSTRAINT item_id FOREIGN KEY (item_ID) REFERENCES Item (item_ID)
);

-- ORDER_STATUS
DROP TABLE IF EXISTS ORDER_STATUS;
CREATE TABLE ORDER_STATUS (
    status_Order_ID VARCHAR(10) NOT NULL,
    [status] VARCHAR(40) NULL,
    status_Timestamp VARCHAR(20) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT Status_PK PRIMARY KEY (Status_Order_ID, Status_Timestamp),
    CONSTRAINT STATUS_fk_Order FOREIGN KEY (status_order_ID) REFERENCES Customer_Order (order_ID)
);

-- Payment
DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment (
    payment_id VARCHAR(10) NOT NULL,
    order_id VARCHAR(10) NOT NULL,
    payment_date DATE NULL,
    total_amount DECIMAL(12, 2) NULL,
    card_n VARCHAR(16) NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (payment_id),
    CONSTRAINT Payment_fk_CARDNUM FOREIGN KEY (card_n) REFERENCES CARD (card_number),
    CONSTRAINT Payment_fk_Customer_Order FOREIGN KEY (order_id) REFERENCES Customer_Order (order_ID)
);

-- Returns
DROP TABLE IF EXISTS Returns;
CREATE TABLE Returns (
    returns_ID VARCHAR(10) NOT NULL,
    refund_amount DECIMAL(12, 2) NOT NULL,
    returns_date DATE NOT NULL,
    order_ID VARCHAR(10) NOT NULL,
    card_n VARCHAR(16) NOT NULL,
    CONSTRAINT returns_pk PRIMARY KEY (returns_ID),
    CONSTRAINT returns_order FOREIGN KEY (order_ID) REFERENCES Customer_Order (order_ID),
    CONSTRAINT c_card FOREIGN KEY (card_n) REFERENCES CARD (card_number)
);

-- Return_line_item
DROP TABLE IF EXISTS Return_line_item;
CREATE TABLE Return_line_item (
    return_ID VARCHAR(10) NOT NULL,
    return_item_ID VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    order_item VARCHAR(10) NOT NULL,
    order_ID VARCHAR(10) NOT NULL,
    CONSTRAINT Return_line_item_pk PRIMARY KEY (return_ID, return_item_ID),
    CONSTRAINT Return_line_item_fk_RETURN FOREIGN KEY (return_ID) REFERENCES Returns (returns_ID),
    CONSTRAINT Return_line_fk_id_ITEM FOREIGN KEY (order_ID, order_item) REFERENCES Order_Item (order_ID, order_item_ID)
);

-- Review
DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
    review_ID VARCHAR(10) NOT NULL,
    r_star NUMERIC(12, 2) NOT NULL,
    comments VARCHAR(255),
    reviewDate DATE NOT NULL,
    useful_flag INT,
    num_of_words INT,
    review_account VARCHAR(10) NOT NULL,
    review_item VARCHAR(10) NOT NULL,
    CONSTRAINT useful_flag CHECK (useful_flag IN (1, 0)),
    CONSTRAINT review_pk PRIMARY KEY (review_ID),
    CONSTRAINT r_account FOREIGN KEY (review_account) REFERENCES Account (account_ID),
    CONSTRAINT r_item FOREIGN KEY (review_item) REFERENCES Item (item_ID)
);

-- Save_For_Later
--DROP TABLE IF EXISTS Save_For_Later;
CREATE TABLE Save_For_Later (
    sfl_account_ID VARCHAR(10) NOT NULL,
    sfl_ID VARCHAR(10) NOT NULL,
    sfl_item_ID VARCHAR(10) NOT NULL,
    save_Date DATE NOT NULL,
    CONSTRAINT Save_For_Later_pk PRIMARY KEY (sfl_account_ID, sfl_ID),
    CONSTRAINT Save_For_Later_fk_ACCOUNT FOREIGN KEY (sfl_account_ID) REFERENCES Account (account_ID),
    CONSTRAINT Save_For_Later_fk_ITEM FOREIGN KEY (sfl_item_ID) REFERENCES Item (item_ID)
);
