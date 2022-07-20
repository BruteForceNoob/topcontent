

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
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
        //  splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            html.window.open(articleData.link, "_blank");
          },
          child: Column(
            children: [
              ListTile(
                leading: ImageRenderer(
                  alt:"Feed image",
                  src: articleData.source,
                  child:CachedNetworkImage(imageUrl: articleData.feedSourceImgLink, width:80)),
                
                ),
              
              Expanded(child: ImageRenderer(
              alt:"Post Image",
              child: Ink.image(image: CachedNetworkImageProvider(articleData.imageURL.isNotEmpty
                  ? articleData.imageURL
                  : articleData.feedSourceImgLink,
              
                 ),
                   alignment: Alignment.center,
                   
                   fit: BoxFit.fill,
                  )),
              ),
               ListTile(
                minVerticalPadding: 20,
                
                title: TextRenderer(
                  style: TextRendererStyle.header1,
                  child: Text(articleData.title, style: const TextStyle(fontWeight: FontWeight.bold)), 
                ), 
                subtitle: TextRenderer(
                  style: TextRendererStyle.header3,
                  child:Text(articleData.author)),

               ), 
               ListTile(
                minVerticalPadding: 20,
                
                title: TextRenderer(
                  style: TextRendererStyle.paragraph,
                  child: Text(articleData.description, style:TextStyle(color: Colors.black.withOpacity(0.8))), 
                ), 
              

               ),         
              
            ],
          )),
    );
  }
}
