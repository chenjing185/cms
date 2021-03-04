package com.etc.dao;

import java.util.List;

import com.etc.entity.Article;
import com.etc.util.PageData;

public interface ArticleDao {
	//查询所有article
	List<Article> queryArticles();

	/**
	 * 增加文章
	 * @param article 新增的文章信息
	 * @return true:增加成功 false:增加失败
	 */
	boolean insertArticle(Article article);
	//根据文章编号删除文章
	boolean deleteArticle(int articleId);
	
	//模糊查询所有文章
	List<Article> queryArticlesLike(String articleLike);
	
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
	List<Article> queryTopArticle();
	
	/**
	 * 根据id查文章
	 * @param articleId
	 * @return
	 */
	Article queryArticleById(int articleId);
	/**
	 * 分页+模糊查询
	 * @param pageNo 当前页码
	 * @param pageSize 一页显示几条
	 * @param titleKey   模糊查询标题的关键字
	 * @return
	 */
	PageData  queryArticleByLikePage(int pageNo,int pageSize,String titleKey);
}
