

import 'package:flutter/material.dart';
import 'package:topcontent/core/Article.dart';
import 'dart:html' as html;



class ArticleCard extends StatelessWidget {
  ArticleCard(this.articleData, {Key? key}) : super(key: key);
  Article articleData;
  

  
  @override
  Widget build(BuildContext context) {


  
    return Card(
      clipBehavior: Clip.antiAlias,
     

      
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            html.window.open(articleData.link, "_blank");
          },
          child: Column(
            children: [
              ListTile(
                leading: Image.network(articleData.feedSourceImgLink),
              ),
              Expanded(child: 
              Ink.image(image: NetworkImage(articleData.imageURL.isNotEmpty
                  ? articleData.imageURL
                  : articleData.feedSourceImgLink,
                  
                 ),
                   alignment: Alignment.center,
                   height:200,
                  ),
              ),
               ListTile(
                minVerticalPadding: 20,
                
                title: Text(articleData.title),
                subtitle: Text(articleData.author),

               ),     
              
            ],
          )),
    );
  }
}
