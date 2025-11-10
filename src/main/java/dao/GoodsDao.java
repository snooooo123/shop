package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Goods;
import dto.GoodsImg;

public class GoodsDao {
	public List<Map<String, Object>> selectBestGoodsList(int beginRow, int rowPerPage) {
	
		String sql = """
					select
						gi.filename
						, g.goods_code
						, g.goods_name
						, g.goods_price
					from
					goods g inner join goods_img gi
					on g.goods_code = gi.goods_code
					    inner join (select goods_code, count(*) from orders
					                    group by goods_code
					                    order by count(*) desc
					                    offset 0 rows fetch next 5 rows only) t
					on g.goods.code = t.goods_code;
				""";
		
		return list;
		
	}
	// 상품등록 + 이미지 등록
	// 반환값은 실패시 false 
	public boolean insertGoodsAndImg(Goods g, GoodsImg gi) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement stmtSeq = null; // select
		PreparedStatement stmtGoods = null; // insert
		PreparedStatement stmtImg = null; // insert
		ResultSet rs = null;
		
		String sqlSeq= """
						select seq_goods.nextval from dual
				""";
		
		String sqlGoods = """
						insert into goods(goods_code, goods_name, goods_price, soldout, emp_code, point_rate, createdate)
						values(?, ?, ?, null, ?, ?, sysdate)
				""";
		String sqlImg = """
						insert into goods_img(goods_code, filename, origin_name, content_type, filesize, createdate)
						values(?, ?, ?, ?, ?, sysdate)
				""";
		
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 단일 트랜잭션안에서 시퀀스 생성 -> 상품입력 -> 이미지입력
			
			// seq_goods.nextval 값을 먼저 생성 후 사용
			stmtSeq = conn.prepareStatement(sqlSeq);
			rs = stmtSeq.executeQuery();
			rs.next();
			int goodsCode = rs.getInt(1);
			
			// 2) goods 입력
			stmtGoods = conn.prepareStatement(sqlGoods);
			stmtGoods.setInt(1, goodsCode);
			stmtGoods.setString(2, g.getGoodsName());
			stmtGoods.setInt(3, g.getGoodsPrice());
			stmtGoods.setInt(4, g.getEmpCode());
			stmtGoods.setDouble(5, g.getPointRate());
			int row1 = stmtGoods.executeUpdate();
			// 상품입력에 실패하면
			if(row1 != 1) {
				//conn.rollback(); return result;
				throw new SQLException();
			}
			
			
			// 3) goodsImg 입력
			stmtImg = conn.prepareStatement(sqlImg);
			stmtImg.setInt(1, goodsCode);
			stmtImg.setString(2, gi.getFilename());
			stmtImg.setString(3, gi.getOriginName());
			stmtImg.setString(4, gi.getContentType());
			stmtImg.setLong(5, gi.getFilesize());
			int row2 = stmtImg.executeUpdate();
			if(row2!=1) {
				// conn.rollback(); return false;
				throw new SQLException();												
			}	
			result = true; // 상품 & 이미지 입력성공
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				stmtImg.close(); stmtGoods.close(); stmtSeq.close(); conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	public List<Map<String, Object>> selectGoodsList(int beginRow, int rowPerPage) {
		List<Map<String, Object>> list= new ArrayList<>();;
		Goods goods;
		Connection conn = null;
		PreparedStatement stmt = null; // select		
		ResultSet rs = null;
		
		String sql = """
					select
						gi.filename
						g.goods_code
						, g.goods_name
						, g.goods_price
					where g.soldout is null
					from goods g inner join goods_img gi
					on g.goods_code = gi.goods_code
					order by g.goods_code desc
					offset ? rows fetch next ? rows only									
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				m.put("filename",rs.getString("filename"));
				m.put("goods_code",rs.getInt("goods_code"));
				m.put("goods_name",rs.getString("goods_name"));
				m.put("goods_price",rs.getInt("goods_price"));

				list.add(m);
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
/* 
 * 상품 목록
 * emp/goodsList 에서는 10개  /  customerIndex 에서는 20개
 */ 
	public List<Goods> selectGoodsListByEmp(int beginRow, int rowPerPage) throws SQLException{
		List<Goods> list= new ArrayList<>();;
		Goods goods;
		Connection conn = null;
		PreparedStatement stmt = null; // select		
		ResultSet rs = null;
		
		String sql = """
					select goods_code, goods_name, goods_price, soldout
					, emp_code, point_rate, createdate
					from goods
					offset ? rows fetch next ? rows only
				""";
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			goods =  new Goods();
			goods.setGoodsCode(rs.getInt("goods_code"));
			goods.setGoodsName(rs.getString("goods_Name"));
			goods.setGoodsPrice(rs.getInt("goods_price"));
			goods.setSoldout(rs.getString("soldout"));
			goods.setEmpCode(rs.getInt("emp_code"));
			goods.setPointRate(rs.getDouble("point_rate"));
			goods.setCreatedate(rs.getString("createdate"));
			list.add(goods);
		}
		
		rs.close(); stmt.close(); conn.close();	
		return list;
	}
/* 
 * 상품 목록 페이징
 */ 	
	public int countGoodsList() throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null; 		
		ResultSet rs = null;		
		String sql = """
					select count(*) from Goods
				""";
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		int cnt=0;
		if(rs.next()) {
			cnt = rs.getInt(1);
		}		
		
		rs.close(); stmt.close(); conn.close();	
		return cnt;
	}	
}
