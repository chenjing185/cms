package com.etc.test;

import java.util.List;

import org.junit.Test;

import com.etc.entity.Article;
import com.etc.service.impl.ArticleServiceImpl;
import com.etc.util.PageData;

public class ArticleTest {
	ArticleServiceImpl service=new ArticleServiceImpl();
	
	@Test
	public void getArt() {
		List<Article> list = service.getArticles();
		for (Article article : list) {
			System.out.println(article);
		}
	}
	
	@Test
	public void addArt() {
		boolean f = service.addArticle(new  Article(0, "春运", "很多人被退票", "zzh", null));
		System.out.println(f);
	}

	@Test
	public void deleArt() {
		boolean f = service.deleteArticle(19);
		System.out.println(f);
	}
	
	@Test
	public void getArtByLike() {
		List<Article> list = service.getArticlesLike("低头");
		for (Article article : list) {
			System.out.println(article);
		}
	}
	
	
	@Test
	public void updateArt() {
		boolean b = service.updateArticle(new Article(6, "天气", "今天天气不错,心情不错", "zq", null));
		System.out.println(b);
	}
	
	@Test
	public void getArtByTop() {
		List<Article> list = service.getTopArticle();
		for (Article article : list) {
			System.out.println(article);
		}
	}
	
	@Test
	public void queryArtId() {
		Article b = service.getArticleId(7);
		System.out.println(b);
	}
	
	@Test
	public void getAr2() {
		PageData pageData = service.getArticle2(1, 3, "");
		List<Article> data = pageData.getData();
		for (Article a : data) {
			System.out.println(a);
		}
		System.out.println("当前第:"+pageData.getPageNo()+"页");
		System.out.println("每页显示:"+pageData.getPageSize()+"条");
		System.out.println("共:"+pageData.getTotalPage()+"页");
		System.out.println("一共:"+pageData.getTotalCount()+"条");
		
	}
}
