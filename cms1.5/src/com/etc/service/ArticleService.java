package com.etc.service;

import java.util.List;

import com.etc.entity.Article;
import com.etc.util.PageData;

public interface ArticleService {
	//得到所有article
	List<Article> getArticles();
	/**
	 * 增加文章
	 * @param article 新增的文章信息
	 * @return true:增加成功 false:增加失败
	 */
	boolean addArticle(Article article);
	
	//根据文章编号删除文章
	boolean deleteArticle(int articleId);
	
	//模糊查询所有文章
	List<Article> getArticlesLike(String articleLike);

	
	/**
	 * 修改文章内容
	 * @param article 新的数据
	 * @return true 修改成功 ,false修改失败
	 */
	boolean updateArticle(Article article);
	
	/**
	 * 查询前3条文章
	 * @return
	 */
	List<Article> getTopArticle();
	
	/**
	 * 根据id查文章
	 * @param articleId
	 * @return
	 */
	Article getArticleId(int articleId);
	
	PageData  getArticle2(int pageNo,int pageSize,String key);
}
