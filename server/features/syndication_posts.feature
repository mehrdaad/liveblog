Feature: Syndication Blog Posts Resource

    Scenario: List blog posts
        Given "themes"
        """
        [{"name": "forest"}]
        """
        Given "blogs"
        """
        [
            {
                "title": "testBlog",
                "blog_status": "open",
                "syndication_enabled": true,
                "blog_preferences": {"theme": "forest", "language": "fr"}
            }
        ]
        """
        When we post to "items"
        """
        [{"text": "test", "blog": "#blogs._id#"}]
        """
        And we post to "posts"
        """
        [{
            "blog": "#blogs._id#",
            "groups": [
                {"id": "root", "refs": [{"idRef": "main"}], "role": "grpRole:NEP"},
                {
                    "id": "main",
                    "refs": [
                        {
                            "headline": "test post with text",
                            "residRef": "#items._id#",
                            "slugline": "awesome article"
                        }
                    ],
                    "role": "main"
                }
            ]
        }]
        """
        Given config consumer api_key
        When we get "/syndication/blogs/#blogs._id#/posts/"
        Then we get list with 1 items
