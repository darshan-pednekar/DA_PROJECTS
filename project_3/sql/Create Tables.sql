-- ==========================
-- CREATING TABLES
-- ==========================

-- Regions Dimension
CREATE TABLE ads_data.dim_regions (
    region_id INT PRIMARY KEY,
    country VARCHAR(100),
    city VARCHAR(100),
    market_segment VARCHAR(50)
);

-- Customers Dimension
CREATE TABLE ads_data.dim_customers (
    customer_id INT PRIMARY KEY,
    age_group VARCHAR(50),
    gender VARCHAR(20),
    income_level VARCHAR(50)
);

-- Campaigns Dimension
CREATE TABLE ads_data.dim_campaigns (
    campaign_id INT PRIMARY KEY,
    campaign_name VARCHAR(150),
    start_date DATE,
    end_date DATE,
    objective VARCHAR(50)
);

-- Ads Dimension
CREATE TABLE ads_data.dim_ads (
    ad_id INT PRIMARY KEY,
    ad_type VARCHAR(50),
    device_type VARCHAR(50),
    placement VARCHAR(100)
);

-- Keywords Dimension
CREATE TABLE ads_data.dim_keywords (
    keyword_id INT PRIMARY KEY,
    keyword VARCHAR(100),
    match_type VARCHAR(50)
);

-- Fact Table
CREATE TABLE ads_data.fact_campaign_performance (
    date DATE,
    campaign_id INT REFERENCES ads_data.dim_campaigns(campaign_id),
    ad_id INT REFERENCES ads_data.dim_ads(ad_id),
    keyword_id INT REFERENCES ads_data.dim_keywords(keyword_id),
    region_id INT REFERENCES ads_data.dim_regions(region_id),
    customer_id INT REFERENCES ads_data.dim_customers(customer_id),
    impressions NUMERIC,
    clicks NUMERIC,
    conversions NUMERIC,
    cost NUMERIC(12,2),
    revenue NUMERIC(12,2)
);
