package it.fudeo.news_app.services;

import java.util.List;

import it.fudeo.news_app.Pigeon;
import it.fudeo.news_app.models.EverythingResponse;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class PigeonArticleApi implements Pigeon.ArticleApi {

    private final ArticleService articleService;

    public PigeonArticleApi(ArticleService articleService) {
        this.articleService = articleService;
    }

    @Override
    public void articles(Pigeon.Result<List<Pigeon.Article>> result) {
        articleService.everything().enqueue(new Callback<EverythingResponse>() {
            @Override
            public void onResponse(Call<EverythingResponse> call, Response<EverythingResponse> response) {
                result.success(response.body() != null ? response.body().getArticles() : null);
            }

            @Override
            public void onFailure(Call<EverythingResponse> call, Throwable t) {
                result.error(t);
            }
        });
    }
}
