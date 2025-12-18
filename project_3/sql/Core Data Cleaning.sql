-- ==========================
-- CLEANING DIMENSION TABLES
-- ==========================

-- 1.1 Clean Regions (typos, standardization)
SELECT DISTINCT country, market_segment FROM ads.dim_regions;

-- Fixes
UPDATE ads_data.dim_regions
SET country = 'India'
WHERE LOWER(country) IN ('indai','indaia');

UPDATE ads_data.dim_regions
SET market_segment = 'Tier 1'
WHERE market_segment IN ('Tier-1','tier1');


-- 1.2 Clean Customers (age groups, income level typos)
SELECT DISTINCT age_group, income_level FROM ads_data.dim_customers;

-- Fixes
UPDATE ads_data.dim_customers
SET age_group = '18-25'
WHERE age_group IN ('18to25','18_25');

UPDATE ads_data.dim_customers
SET gender = 'Male'
WHERE gender = 'Mlae';

UPDATE ads_data.dim_customers
SET income_level = 'Medium'
WHERE LOWER(income_level) IN ('medum','med');

-- 1.3 Clean Campaigns (objectives, date validations)
SELECT DISTINCT objective FROM ads_data.dim_campaigns;

-- Fixes
UPDATE ads_data.dim_campaigns
SET objective = 'Conversion'
WHERE LOWER(objective) IN ('convertion','convsn');

-- Check invalid date ranges
SELECT * FROM ads_data.dim_campaigns
WHERE end_date < start_date;


-- 1.4 Clean Ads (ad_type, device_type typos)
SELECT DISTINCT ad_type, device_type FROM ads_data.dim_ads;

-- Fixes
UPDATE ads_data.dim_ads
SET ad_type = 'Video'
WHERE LOWER(ad_type) IN ('vidoe','vedio');

UPDATE ads_data.dim_ads
SET device_type = 'Mobile'
WHERE LOWER(device_type) IN ('moblie','mobi');

UPDATE ads_data.dim_ads
SET placement = 'Display Network'
WHERE placement = 'Desplay Network';

-- 1.5 Clean Keywords (match types)
SELECT DISTINCT match_type FROM ads_data.dim_keywords;

-- Fixes
UPDATE ads_data.dim_keywords
SET match_type = 'Broad'
WHERE LOWER(match_type) IN ('brd','brad');

UPDATE ads_data.dim_keywords
SET match_type = 'Phrase'
WHERE match_type = 'Pharse';