SELECT 
    k.keyword,
    SUM(f.impressions) AS impressions,
    SUM(f.clicks) AS clicks,
    SUM(f.conversions) AS conversions,
    ROUND(SUM(f.cost)::numeric, 2) AS total_cost,
    ROUND(SUM(f.revenue)::numeric, 2) AS total_revenue,
	ROUND((SUM(clicks)::numeric / NULLIF(SUM(impressions)::numeric,0)) * 100, 2) AS ctr,
    ROUND((SUM(conversions)::numeric / NULLIF(SUM(clicks)::numeric,0)) * 100, 2) AS cvr,
    ROUND((SUM(f.revenue)::numeric - SUM(f.cost)::numeric), 2) AS profit,
    ROUND(((SUM(f.revenue)::numeric - SUM(f.cost)::numeric) / NULLIF(SUM(f.cost)::numeric,0)) * 100, 2) AS roi
FROM ads_data.fact_campaign_performance_cleaned f
JOIN ads_data.dim_keywords k ON f.keyword_id = k.keyword_id
GROUP BY k.keyword
ORDER BY roi DESC;
