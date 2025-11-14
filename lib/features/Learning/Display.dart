import 'package:flutter/material.dart';
import '../Learning/Story_screen.dart';

class StoryDemoPage extends StatelessWidget {
  const StoryDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final story = {
      "title": "Mahajanapadas: The Rise of Kingdoms in Ancient India",
      "topicId": "6744ef12e91c92c8bb47e52a",
      "blocks": [
        {
          "type": "heading",
          "content": {"text": "Introduction", "level": 2}
        },
        {
          "type": "paragraph",
          "content": {
            "children": [
              {
                "text":
                    "Between the 6th and 4th centuries BCE, India witnessed a significant transformation in its political and social landscape. "
              },
              {
                "text":
                    "Small tribal units evolved into large territorial states",
                "bold": true
              },
              {"text": " — known as the "},
              {"text": "Mahajanapadas", "italic": true, "color": "#2f4f4f"},
              {
                "text":
                    ". These states marked the early phase of urbanization and centralized governance in Indian history."
              }
            ]
          }
        },
        {
          "type": "image",
          "content": {
            "url":
                "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761448385/uploads/huu5hznkiii4awr4moku.png",
            "caption": "Map showing the 16 Mahajanapadas around 600 BCE."
          }
        },
        {
          "type": "heading",
          "content": {"text": "The Sixteen Mahajanapadas", "level": 2}
        },
        {
          "type": "list",
          "content": {
            "style": "bulleted",
            "items": [
              "Kashi",
              "Kosala",
              "Anga",
              "Magadha",
              "Vajji",
              "Malla",
              "Chedi",
              "Vatsa",
              "Kuru",
              "Panchala",
              "Matsya",
              "Surasena",
              "Assaka",
              "Avanti",
              "Gandhara",
              "Kamboja"
            ]
          }
        },
        {
          "type": "paragraph",
          "content": {
            "children": [
              {"text": "Among these, "},
              {"text": "Magadha", "bold": true},
              {
                "text":
                    " emerged as the most powerful and prosperous kingdom, paving the way for future empires such as the Mauryas."
              }
            ]
          }
        },
        {
          "type": "quote",
          "content": {
            "children": [
              {
                "text":
                    "“From clan-based republics to powerful monarchies, the Mahajanapadas symbolize India’s first major step toward organized governance.”"
              }
            ],
            "author": "NCERT Class VI – Our Pasts"
          }
        },
        {
          "type": "heading",
          "content": {"text": "Governance and Economy", "level": 2}
        },
        {
          "type": "paragraph",
          "content": {
            "children": [
              {"text": "Most Mahajanapadas were monarchies, though some like "},
              {"text": "Vajji", "bold": true},
              {
                "text":
                    " had republican systems of governance. Their economy was based on "
              },
              {"text": "agriculture, trade, and coinage", "italic": true},
              {
                "text":
                    ", marking a shift from barter systems to metal currencies such as punch-marked coins."
              }
            ]
          }
        },
        {
          "type": "image",
          "content": {
            "url":
                "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761448385/uploads/huu5hznkiii4awr4moku.png",
            "caption": "Punch-marked coins used during the Mahajanapada period."
          }
        },
        {
          "type": "heading",
          "content": {"text": "Sample UPSC Question", "level": 3}
        },
        {
          "type": "question",
          "content": {
            "statement":
                "Which of the following Mahajanapadas was known for its republican form of government?",
            "options": [
              {"statement": "Magadha"},
              {"statement": "Kosala"},
              {"statement": "Vajji"},
              {"statement": "Kashi"}
            ],
            "correctAnswer": "Vajji"
          }
        },
        {
          "type": "paragraph",
          "content": {
            "children": [
              {
                "text":
                    "The Vajji confederacy, with its capital at Vaishali, followed a republican system where power rested with an assembly of elders known as the "
              },
              {"text": "Gana-Sangha", "italic": true},
              {"text": "."}
            ]
          }
        },
        {
          "type": "quote",
          "content": {
            "children": [
              {
                "text":
                    "“The concept of participatory governance seen in the Vajji Sangha later inspired Buddhist monastic orders.”"
              }
            ],
            "author": "Dr. Romila Thapar"
          }
        },
        {
          "type": "heading",
          "content": {"text": "Conclusion", "level": 2}
        },
        {
          "type": "paragraph",
          "content": {
            "children": [
              {
                "text":
                    "The Mahajanapadas laid the foundation for India’s classical age of empires. Their rise reflects the growing complexity of society, economy, and governance — all of which form a key part of UPSC’s Ancient Indian History syllabus."
              }
            ]
          }
        }
      ],
      "_id": "6914e0dd4373fc9ee3b76e83",
      "date": "2025-11-12T19:32:45.497Z",
      "createdAt": "2025-11-12T19:32:45.506Z",
      "updatedAt": "2025-11-12T19:32:45.506Z",
      "__v": 0
    };

    return StoryScreen(story: story);
  }
}
