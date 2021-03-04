package com.etc.service.impl;

import java.util.List;

import com.etc.dao.ArticleDao;
import com.etc.dao.impl.ArticleDaoImpl;
import com.etc.entity.Article;
import com.etc.service.ArticleService;
import com.etc.util.PageData;

public class ArticleServiceImpl implements ArticleService {
	ArticleDao dao=new ArticleDaoImpl();
	@Override
	public List<Article> getArticles() {
		
		return dao.queryArticles();
	}
	@Override
	public boolean addArticle(Article article) {
		return dao.insertArticle(article);
	}
	@Override
	public boolean deleteArticle(int articleId) {
		// TODO Auto-generated method stub
		return dao.deleteArticle(articleId);
	}
	@Override
	public List<Article> getArticlesLike(String articleLike) {
		return dao.queryArticlesLike(articleLike);
	}
	@Override
	public boolean updateArticle(Article article) {
		// TODO Auto-generated method stub
		return dao.updateArticle(article);
	}
	@Override
	public List<Article> getTopArticle() {
		// TODO Auto-generated method stub
		return dao.queryTopArticle();
	}
	@Override
	public Article getArticleId(int articleId) {
		// TODO Auto-generated method stub
		return dao.queryArticleById(articleId);
	}
	@Override
	public PageData getArticle2(int pageNo, int pageSize, String key) {
		return dao.queryArticleByLikePage(pageNo, pageSize, key);
	}

}
