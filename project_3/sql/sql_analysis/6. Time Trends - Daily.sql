SELECT 
    date,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(cost)::numeric, 2) AS total_cost,
    ROUND(SUM(revenue)::numeric, 2) AS total_revenue,
	ROUND((SUM(clicks)::numeric / NULLIF(SUM(impressions)::numeric,0)) * 100, 2) AS ctr,
    ROUND((SUM(conversions)::numeric / NULLIF(SUM(clicks)::numeric,0)) * 100, 2) AS cvr,
    ROUND((SUM(revenue)::numeric - SUM(cost)::numeric), 2) AS profit,
	ROUND(((SUM(revenue)::numeric - SUM(cost)::numeric) / NULLIF(SUM(cost)::numeric,0)) * 100, 2) AS roi
FROM ads_data.fact_campaign_performance_cleaned
GROUP BY date
ORDER BY date;
