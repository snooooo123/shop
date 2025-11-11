package dao;

import java.util.Map;

public class StatsDao {
	// 11 개  chart 메서드
	
	/*
	 *	특정년도의 월별 주문횟수(누적)
	 */
	public Map<String, Object> selectOrderTotalCntByYM(String fromYM, String toYM) {
		String sql = """
					SELECT t.ym					
						   , SUM(t.cnt) OVER(order by t.ym ASC) sum				    
				    FROM   
				    	(SELECT to_char(createdate, 'yyyy-mm') ym
				        		, count(*) cnt
				        FROM orders
				        WHERE createdate
				        BETWEEN to_date('2025-01-01', 'yyyy-mm-dd')
				        AND to_date('2025-12-31', 'yyyy-mm-dd')
				        GROUP BY to_char(createdate, 'yyyy-mm')) t
				""";
		return null;
	}
	/*
	 *	특정년도의 월별 주문금액(누적)
	 */
	public Map<String, Object> selectOrderTotalPriceByYM(String fromYM, String toYM) {
		String sql = """
					SELECT t.ym
						   , 
						   
						SELECT to_char(createdate, 'yyyy-mm') ym
							   , SUM(order_price) OVER(
						FROM orders
						BETWEEN to_date('2025-01-01', 'yyyy-mm-dd')
				        AND to_date('2025-12-31', 'yyyy-mm-dd')
				        GROUP BY to_char(createdate, 'yyyy-mm')
				""";
		return null;
	}
}
