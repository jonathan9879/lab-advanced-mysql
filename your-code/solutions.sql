CREATE TEMPORARY TABLE royalty_table_4
SELECT *
FROM (
	SELECT author, TRUNCATE(SUM(royalties), 3) AS profit
	FROM (
		SELECT author, title, SUM(sales_royalty) AS royalties
		FROM (
			SELECT titleauthor.`title_id` AS title, titleauthor.`au_id` AS author, titles.`price` * sales.`qty` * titles.`royalty` / 100 * titleauthor.`royaltyper` / 100 AS 		sales_royalty
		FROM sales
		LEFT JOIN titleauthor ON sales.`title_id` = titleauthor.`title_id`
		LEFT JOIN titles ON sales.`title_id` = titles.`title_id`) AS royalty_table_1
		GROUP BY author, title ) AS royalty_table_2
	GROUP BY author
	ORDER BY profit DESC) AS royalty_table_3; 
