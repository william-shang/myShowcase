# This Python file uses the following encoding: utf-8
article="""
Thank you for using GitHub! We're happy you're here. Please read this Terms of Service agreement carefully before accessing or using GitHub. Because it is such an important contract between us and our users, we have tried to make it as clear as possible. For your convenience, we have presented these terms in a short non-binding summary followed by the full legal terms.
"""
#wordcount counts the words in the article
def wordcount(thearticle):
    #count the words here
    count = len(thearticle.split())
    return count
#charcount counts how many characters are in the article
def charcount(thearticle):
    count = len(thearticle)
    return count
print("word count="+str(wordcount(article)))
print("char count="+str(charcount(article)))
