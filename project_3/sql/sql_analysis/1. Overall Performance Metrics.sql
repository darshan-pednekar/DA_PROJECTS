SELECT 
    COUNT(DISTINCT campaign_id) AS total_campaigns,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(cost)::numeric, 2) AS total_cost,
    ROUND(SUM(revenue)::numeric, 2) AS total_revenue,
    ROUND((SUM(clicks)::numeric / NULLIF(SUM(impressions)::numeric,0)) * 100, 2) AS avg_ctr,
    ROUND((SUM(conversions)::numeric / NULLIF(SUM(clicks)::numeric,0)) * 100, 2) AS avg_cvr,
    ROUND((SUM(revenue)::numeric - SUM(cost)::numeric), 2) AS net_profit,
    ROUND(((SUM(revenue)::numeric - SUM(cost)::numeric) / NULLIF(SUM(cost)::numeric,0)) * 100, 2) AS overall_roi
FROM ads_data.fact_campaign_performance_cleaned;
