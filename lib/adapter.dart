import 'dart:convert';

class PostAPI1 {
  String getYoutubePosts() {
    return '''
    [
      {
        "title": "Automatic Code Generation with Flutter",
        "description": "Generate Automatically"
      },
      {
        "title": "Twitter or X Clone with Flutter",
        "description": "Clones"
      }
    ]
    ''';
  }
}

class PostAPI2 {
  String getMediumPosts() {
    return '''
    [
      {
        "header": "Authentication using Firebase with Flutter",
        "bio": "Crash Course"
      },
      {
        "header": "How to be Flutter Developer in 1 Hours",
        "bio": "Crash Course"
      }
    ]
    ''';
  }
}

abstract class IPostAPI {
  List<Post> getPosts();
}

class Post {
  final String title;
  final String bio;

  Post({required this.title, required this.bio});
}

class PostAPI1Adapter implements IPostAPI {
  final api = PostAPI1();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(api.getYoutubePosts()) as List;
    return data
        .map((e) => Post(title: e['title'], bio: e['description']))
        .toList();
  }
}

class PostAPI2Adapter implements IPostAPI {
  final api = PostAPI2();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(api.getMediumPosts()) as List;
    return data.map((e) => Post(title: e['header'], bio: e['bio'])).toList();
  }
}

class PostAPI implements IPostAPI {
  final api1 = PostAPI1Adapter();
  final api2 = PostAPI2Adapter();

  @override
  List<Post> getPosts() {
    return api1.getPosts() + api2.getPosts();
  }
}
