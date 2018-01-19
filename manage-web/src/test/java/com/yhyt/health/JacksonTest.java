package com.yhyt.health;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.yhyt.health.model.vo.ArticleVO;
import org.junit.Test;

import java.io.IOException;

public class JacksonTest {

    @Test
    public void testJackson() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
//        ArticleDTO articleDTO = new ArticleDTO();
//        Article article = new Article();
//        article.setClickCount(0);
//        articleDTO.setArticle(article);
        String jsonString="{\"clickCount\":0}";
        ObjectMapper objectMapper = mapper.configure(DeserializationFeature.ACCEPT_EMPTY_ARRAY_AS_NULL_OBJECT, true);
        objectMapper.getSerializerProvider().setNullValueSerializer(new JsonSerializer<Object>() {
            @Override
            public void serialize(Object o, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
                jsonGenerator.writeString("");
            }
        });
        ArticleVO articleDTO = objectMapper.readValue(jsonString, ArticleVO.class);

        System.out.println(JSON.toJSONString(articleDTO));

    }
}
