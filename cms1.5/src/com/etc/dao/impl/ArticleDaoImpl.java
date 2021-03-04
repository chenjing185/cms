package com.etc.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.CachedRowSet;

import com.etc.dao.ArticleDao;
import com.etc.entity.Article;
import com.etc.util.DButil;
import com.etc.util.PageData;

public class ArticleDaoImpl implements ArticleDao {

	@Override
	public List<Article> queryArticles() {
		Article article =null;
		List<Article> list=new ArrayList<Article>();
		CachedRowSet crs = DButil.execQuery("select * from article");
		try {
			while(crs.next()) {
				int articleId = crs.getInt(1);
				String articleTitle = crs.getString(2);
				String articleContent = crs.getString(3);
				String articleAuthor = crs.getString(4);
				String articleDate = crs.getString(5);
				article = new Article(articleId, articleTitle, articleContent, articleAuthor, articleDate);
				list.add(article);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean insertArticle(Article article) {
		return DButil.execUpdate("insert into article values(null,?,?,?,now())", article.getArticleTitle(),article.getArticleContent(),article.getArticleAuthor());
	}

	@Override
	public boolean deleteArticle(int articleId) {
		return DButil.execUpdate("delete from article where article_id=? ", articleId);
	}

	@Override
	public List<Article> queryArticlesLike(String articleLike) {
		Article article =null;
		List<Article> list=new ArrayList<Article>();
		CachedRowSet crs = DButil.execQuery("select * from article where article_title like ? or article_content like ?", "%"+articleLike+"%","%"+articleLike+"%");
		try {
			while(crs.next()) {
				int articleId = crs.getInt(1);
				String articleTitle = crs.getString(2);
				String articleContent = crs.getString(3);
				String articleAuthor = crs.getString(4);
				String articleDate = crs.getString(5);
				article = new Article(articleId, articleTitle, articleContent, articleAuthor, articleDate);
				list.add(article);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean updateArticle(Article article) {
		return DButil.execUpdate("update article set article_title=?,article_content=?,article_author=?,article_date=now() where article_id=?", article.getArticleTitle(),article.getArticleContent(),article.getArticleAuthor(),article.getArticleId());
	}

	@Override
	public List<Article> queryTopArticle() {
		Article article =null;
		List<Article> list=new ArrayList<Article>();
		CachedRowSet crs = DButil.execQuery("select * from article order by article_date desc limit 0,3");
		try {
			while(crs.next()) {
				int articleId = crs.getInt(1);
				String articleTitle = crs.getString(2);
				String articleContent = crs.getString(3);
				String articleAuthor = crs.getString(4);
				String articleDate = crs.getString(5);
				article = new Article(articleId, articleTitle, articleContent, articleAuthor, articleDate);
				list.add(article);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Article queryArticleById(int articleId) {
		Article article =null;
		CachedRowSet crs = DButil.execQuery("select * from article where article_id=?",articleId);
		try {
			while(crs.next()) {
				int articleId2 = crs.getInt(1);
				String articleTitle = crs.getString(2);
				String articleContent = crs.getString(3);
				String articleAuthor = crs.getString(4);
				String articleDate = crs.getString(5);
				article = new Article(articleId2, articleTitle, articleContent, articleAuthor, articleDate);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return article;
	}

	@Override
	public PageData queryArticleByLikePage(int pageNo, int pageSize, String titleKey) {
		// 1.获取分页的数据
		String sql="SELECT * from article where article_title LIKE ? limit ?,?" ;
		CachedRowSet crs = DButil.execQuery(sql, "%"+titleKey+"%",(pageNo-1)*pageSize,pageSize);
		Article article =null;
		PageData pageData =null;
		List<Article> data=new ArrayList<Article>();
		try {
			while(crs.next()) {
				int articleId = crs.getInt(1);
				String articleTitle = crs.getString(2);
				String articleContent = crs.getString(3);
				String articleAuthor = crs.getString(4);
				String articleDate = crs.getString(5);
				article = new Article(articleId, articleTitle, articleContent, articleAuthor, articleDate);
				data.add(article);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//2.获取总条数
		String sql2="SELECT COUNT(*) from article WHERE article_title like ?";
		CachedRowSet crs2 = DButil.execQuery(sql2, "%"+titleKey+"%");
		int totalCount=0;
		try {
			if(crs2.next()) {
				 totalCount = crs2.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 pageData = new PageData(data, pageNo, pageSize, totalCount);
		
		return pageData;
		
	}

}
