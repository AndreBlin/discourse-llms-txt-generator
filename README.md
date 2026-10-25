# Discourse llms.txt Generator

**Automatically generates llms.txt files for LLM optimization (GEO) on Discourse forums**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.2.0-green.svg)](CHANGELOG.md)
[![Discourse](https://img.shields.io/badge/Discourse-Plugin-brightgreen.svg)](https://www.discourse.org)

**English version** | [Русская версия](README.ru.md)

---

> **MoinHei-Fork:** Gehärtet nach einem Security-Scan am 25.10.2026 (keine Whispers, Anmeldepflicht, versteckte Tags, Markdown-Injektion, Cache und Obergrenze für `llms-full.txt`), siehe [CHANGELOG.md](CHANGELOG.md). Auf moinhei.de ist der Stand per Commit in `app.yml` festgelegt; Updates bewusst einspielen. Der Core liefert `/llms.txt` selbst, das Plugin deckt `/llms-full.txt`, `/sitemaps.txt` sowie Kategorie-, Themen- und Tag-Dateien ab.

## 📚 About llms.txt

This project implements the **[llms.txt standard](https://llmstxt.org/)** for Discourse forums, making your community content discoverable and accessible to Large Language Models (LLMs) and AI systems.

**What is llms.txt?**

The llms.txt standard is a proposed convention (September 2024, Jeremy Howard from Answer.AI) for providing LLM-friendly content from websites. Think of it as "robots.txt for AI" - a standardized way for websites to expose their content structure to AI systems.

Thousands of sites—including many of the world’s largest and most respected tech companies—have already implemented the llms.txt standard on their own domains. Examples include:
- ✅ Amazon AWS — `https://docs.aws.amazon.com/llms.txt`
- ✅ Cloudflare — `https://developers.cloudflare.com/llms.txt`
- ✅ Stripe — `https://stripe.com/llms.txt`
- ✅ Angular — `https://angular.dev/llms.txt`
- ✅ Redis — `https://redis.io/llms.txt`
- ✅ Docker — `https://docs.docker.com/llms.txt`
- ✅ Model Context Protocol — `https://modelcontextprotocol.io/llms-full.txt`

When industry giants adopt a standard at scale—long before it becomes “official”—it’s a clear signal that llms.txt solves a real and urgent problem. Such companies never roll out sitewide initiatives lightly; they always have a solid strategic reason. The rapid, large-scale embrace of llms.txt across the tech industry shows just how important structured content for AI has become, and that the industry itself is driving this adoption forward—even faster than formal standards bodies.

**Learn More:**
- 📖 [Official llms.txt Documentation](https://llmstxt.org/)
- 💻 [llms.txt GitHub Repository](https://github.com/AnswerDotAI/llms-txt)
- 🏢 [Answer.AI](https://www.answer.ai/)

---

## 📋 Table of Contents

### Getting Started
- [What This Does](#-what-this-does)
- [Why You Need This](#-why-you-need-this)
- [Installation](#-installation)

### Core Features
- [Key Features](#-key-features)
- [Generated Files](#generated-files)
- [Dynamic llms.txt Files](#dynamic-llmstxt-files)

### Configuration
- [Basic Setup](#-configuration)
- [Main Settings](#main-settings)
- [Content Settings](#content-settings)
- [Performance Settings](#performance-settings)

### Advanced Topics
- [SEO & Canonical URLs](#seo--canonical-urls)
- [Bot Control & Blocking](#bot-control--blocking)
- [Smart Cache Management](#smart-cache-management)
- [Performance Optimization](#performance-optimization)
- [Privacy & Security](#-privacy--security)

### Resources
- [Troubleshooting](#-troubleshooting)
- [Development](#-development)
- [Support](#-support)
- [Changelog](#-changelog)

---

## 🎯 What This Does

This Discourse plugin automatically generates **LLM-friendly documentation files** for your forum:

### 1. **Main Navigation File** (for AI discovery)
`/llms.txt` - A structured overview helping LLMs understand your forum's organization, categories, and latest discussions.

### 2. **Full Content Index** (for AI training)
`/llms-full.txt` - Complete forum index with all topics, categorized and ready for LLM consumption.

### 3. **Dynamic Resource Files** (for targeted content)
Generate llms.txt for **any category, topic, or tag** on-demand:
- `/c/category-name/123/llms.txt` - All topics in a category
- `/t/topic-slug/456/llms.txt` - Complete topic with all posts
- `/tag/tutorial/llms.txt` - All topics with specific tag

### 4. **Sitemap Index** (for crawler discovery)
`/sitemaps.txt` - Complete list of all llms.txt URLs for efficient AI crawler indexing.

**The Result:** Your forum content becomes discoverable by ChatGPT, Claude, and other AI systems, improving GEO (Generative Engine Optimization) and increasing visibility in AI-generated responses.

---

## 💡 Why You Need This

### The Problem Without This

**Before:**
- AI systems can't efficiently understand your forum structure
- LLMs parse HTML pages (slow, inefficient, error-prone)
- Your valuable community knowledge stays hidden from AI
- AI chatbots can't cite or reference your discussions
- No control over how AI systems access your content

### The Solution With This

**After:**
- ✅ Clean, structured, LLM-friendly content format
- ✅ AI systems understand your forum organization instantly
- ✅ Your content appears in ChatGPT, Claude, and other AI responses
- ✅ Control what AI systems see (bot blocking, content filtering)
- ✅ Better GEO (Generative Engine Optimization) for AI discovery

### Real-World Impact

**Before (without llms.txt):**
```
User: "How do I install XYZ on Ubuntu?"
AI: "I don't have specific information about XYZ installation..."
```

**After (with llms.txt):**
```
User: "How do I install XYZ on Ubuntu?"
AI: "According to the XYZ Forum, here are the installation steps:
     [Detailed answer from your forum]
     Source: https://your-forum.com/t/ubuntu-install/123"
```

**Your forum gets:**
- 🎯 Increased visibility in AI responses
- 🔗 Direct attribution and backlinks
- 📈 More traffic from AI-powered search
- 🌟 Recognition as authoritative source

---

## 📦 Installation

### Quick Install (5 minutes)

**Step 1: Add plugin to Discourse**

For Docker installations (recommended), edit `containers/app.yml`:

```yaml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/kaktaknet/discourse-llms-txt-generator.git
```

**Step 2: Rebuild container**

```bash
cd /var/discourse
./launcher rebuild app
```

**Step 3: Verify installation**

After rebuild completes (~5 minutes), check:

```bash
curl https://your-forum.com/llms.txt
```

**Done!** You should see your forum's llms.txt navigation file.

---

### Manual Installation (Alternative)

For non-Docker or development installations:

```bash
cd /var/www/discourse/plugins
git clone https://github.com/kaktaknet/discourse-llms-txt-generator.git
cd /var/www/discourse
bundle exec rake plugin:install
```

Restart Discourse:

```bash
systemctl restart discourse
```

---

## 🌟 Key Features

### Feature 1: Automatic Generation

**What it does:**
Dynamically generates llms.txt files on-demand without pre-generation or manual updates. Files are created in real-time when requested.

**When to use:**
Always enabled - files appear automatically after installation.

**Example:**
```
GET /llms.txt → Generated instantly with current forum state
GET /c/support/2/llms.txt → Category-specific file created on-demand
```

**Benefits:**
- ✅ No maintenance required
- ✅ Always up-to-date
- ✅ Zero storage overhead

---

### Feature 2: Dynamic Per-Resource llms.txt

**What it does:**
Creates virtual llms.txt files for **any** category, topic, or tag in your forum without physically storing them.

**When to use:**
- AI needs specific category content
- Developers want targeted topic information
- Crawlers request granular data

**Example:**
```markdown
# Request category llms.txt
GET /c/support/2/llms.txt

# Returns:
# Support Category
> Category: My Forum

Get help with installation and troubleshooting.

## Topics
- [How to install on Ubuntu](url) (1523 views)
- [Common errors](url) (892 views)
```

**Benefits:**
- ✅ Granular content control
- ✅ Faster AI indexing
- ✅ Better topic discovery
- ✅ Reduced bandwidth

---

### Feature 3: Smart Caching

**What it does:**
Intelligent hourly cache that only regenerates when new content is created, not on every request.

**When to use:**
Automatic - runs in background every hour.

**Example:**
```
Hour 1: New topic created → Cache regenerated
Hour 2: No new content → Cache reused (saves resources)
Hour 3: Post edited → Cache regenerated
```

**Benefits:**
- ✅ Faster response times (<50ms vs 1-2 seconds)
- ✅ Reduced server load
- ✅ Content stays fresh (max 1 hour old)

---

### Feature 4: Bot Control

**What it does:**
Block specific AI crawler bots from accessing llms.txt files while allowing forum access.

**When to use:**
- Block low-quality AI scrapers
- Control which AI services use your content
- Reduce bandwidth from aggressive crawlers

**Example:**
```yaml
# Configuration
llms_txt_blocked_user_agents: "Omgilibot, ChatGPT-User"

# Generates in robots.txt:
User-agent: Omgilibot
Disallow: /llms.txt
Disallow: /llms-full.txt
```

**Benefits:**
- ✅ Quality control over AI attribution
- ✅ Bandwidth reduction
- ✅ Selective AI access

---

### Feature 5: SEO Integration

**What it does:**
Automatically integrates with robots.txt and sitemap.xml, includes canonical URLs to prevent duplicate content penalties.

**When to use:**
Always active - automatic SEO protection.

**Example:**
```http
# HTTP Response
Link: <https://forum.com/t/topic/123>; rel="canonical"

# Content Footer
**Canonical:** https://forum.com/t/topic/123
**Original content:** https://forum.com/t/topic/123
```

**Benefits:**
- ✅ No SEO penalties
- ✅ Proper attribution
- ✅ Search engines index canonical URLs
- ✅ Complies with RFC 6596

---

## Generated Files

### `/llms.txt` - Navigation File (Lightweight)

Provides a structured overview of your forum:
- Site metadata and description
- Introduction text
- **Categories with Subcategories** - Hierarchical tree structure
- **Latest 50 Topics** - Most recent discussions (configurable)
- Links to additional resources
- Link to full content file

**Example structure:**
```markdown
# My Forum
> Forum description

Introduction text...

## Categories and Subcategories
### [General Discussion](link)
Description of category

- [Help & Support](link): Support subcategory
- [Feature Requests](link): Requests subcategory

## Latest Topics
- [Topic Title](link) - Category Name (2025-11-09)
- [Another Topic](link) - Another Category (2025-11-08)
...
```

---

### `/llms-full.txt` - Full Content File

Contains complete forum index in simplified format:
- **Custom forum description** (optional, appears first)
- **Categories and subcategories** with detailed descriptions
- **Topic list** in format: `**Category** - [Title](link)`
- **Optional post excerpts** (up to 500 characters) - disabled by default

**Why simplified format?**
LLMs can follow links to read full topic content when needed. This approach:
- Reduces file size significantly
- Speeds up generation (no post processing)
- Prevents overwhelming LLMs with too much text
- Allows LLMs to selectively read topics of interest

**Example format without excerpts (default):**
```markdown
**[General Discussion](url)** - [Welcome to our community](url)
**[Help & Support](url)** - [How to install on Ubuntu](url)
```

**Example format with excerpts enabled:**
```markdown
**[General Discussion](url)** - [Welcome to our community](url)
  > Welcome everyone! This is a place where you can introduce yourself...

**[Help & Support](url)** - [How to install on Ubuntu](url)
  > This guide will walk you through installing our software...
```

---

### `/sitemaps.txt` - Index of All llms.txt Files

Contains a complete list of all available llms.txt URLs:
```
https://forum.com/llms.txt
https://forum.com/llms-full.txt
https://forum.com/c/general/1/llms.txt
https://forum.com/c/support/2/llms.txt
https://forum.com/t/welcome-post/123/llms.txt
https://forum.com/t/installation-guide/456/llms.txt
https://forum.com/tag/announcement/llms.txt
...
```

**Purpose:**
- Helps AI crawlers discover all llms.txt resources
- Listed in robots.txt as `Sitemap:` directive
- Automatically updated when content changes
- Respects same privacy and blocking rules

---

## Dynamic llms.txt Files

One of the most powerful features: **virtual llms.txt files for any resource**.

### How It Works

These files **don't physically exist** on your server - they're generated on-demand when requested:

| URL Pattern | Description | Example |
|-------------|-------------|---------|
| `/c/{category-slug}/{id}/llms.txt` | Category with all its topics | `/c/general-discussion/1/llms.txt` |
| `/c/{parent}/{child}/{id}/llms.txt` | Subcategory | `/c/support/installation/15/llms.txt` |
| `/t/{topic-slug}/{id}/llms.txt` | Complete topic with all posts | `/t/how-to-install/123/llms.txt` |
| `/tag/{tag-name}/llms.txt` | All topics with specific tag | `/tag/tutorial/llms.txt` |

### Example: Category llms.txt

Request: `https://forum.com/c/support/2/llms.txt`

Generates:
```markdown
# Support
> Category: My Forum

Get help with installation, configuration, and troubleshooting.

**Category URL:** https://forum.com/c/support/2
**Canonical:** https://forum.com/c/support/2
**Original content:** https://forum.com/c/support/2

## Subcategories

- [Installation Help](https://forum.com/c/install/10): Installation guides and issues
- [Configuration](https://forum.com/c/config/11): Configuration questions

## Topics

- [How to install on Ubuntu](https://forum.com/t/ubuntu-install/456) (1523 views, 45 replies)
- [Common installation errors](https://forum.com/t/install-errors/457) (892 views, 23 replies)
...
```

### Example: Topic llms.txt

Request: `https://forum.com/t/installation-guide/456/llms.txt`

Generates:
```markdown
# Complete Installation Guide

**Category:** [Support](https://forum.com/c/support/2)
**Created:** 2025-11-09 10:30 UTC
**Views:** 1523
**Replies:** 12
**URL:** https://forum.com/t/installation-guide/456
**Canonical:** https://forum.com/t/installation-guide/456
**Original content:** https://forum.com/t/installation-guide/456

---

## Post #1 by @admin

This guide will walk you through installing the software...

[Full post content in Markdown]

---

## Post #2 by @user123

Thanks for this guide! I had an issue with...

[Full post content]

---

...
```

### Example: Tag llms.txt

Request: `https://forum.com/tag/tutorial/llms.txt`

Generates:
```markdown
# Tag: tutorial
> My Forum

**Tag URL:** https://forum.com/tag/tutorial
**Canonical:** https://forum.com/tag/tutorial
**Original content:** https://forum.com/tag/tutorial

## Topics with this tag

- [Getting Started Tutorial](https://forum.com/t/getting-started/123) - General (450 views)
- [Advanced Configuration Tutorial](https://forum.com/t/advanced-config/124) - Configuration (320 views)
...
```

### Why This Is Powerful

**For AI Crawlers:**
- Can request specific content without parsing entire forum
- Get exactly the context they need
- Reduce bandwidth usage
- Faster, more targeted indexing

**For LLM Understanding:**
- Deep dive into specific discussions
- Get full context of conversations
- Access individual topic threads
- Better comprehension of specific subjects

**For Your SEO:**
- Every resource has its own llms.txt
- Granular control over what AI systems see
- Better topic-level discovery
- Improved GEO (Generative Engine Optimization)

### Performance Notes

- **No physical files created** - all generated on-demand
- **No pre-generation needed** - created only when requested
- **Smart caching** - sitemaps.txt is cached
- **Permission-aware** - respects Discourse visibility rules
- **404 for private content** - hidden topics/categories return 404

---

## ⚙️ Configuration

Navigate to **Admin → Settings → Plugins → discourse-llms-txt-generator**

### Main Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `llms_txt_enabled` | `true` | Enable/disable the plugin |
| `llms_txt_allow_indexing` | `true` | Allow AI crawlers (affects robots.txt) |
| `llms_txt_blocked_user_agents` | `""` | Comma-separated bot names to block |
| `llms_txt_intro_text` | Custom text | Introduction for llms.txt file |
| `llms_txt_full_description` | `""` | Custom description for llms-full.txt |

### Content Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `llms_txt_min_views` | `50` | Minimum topic views for inclusion in llms-full.txt |
| `llms_txt_posts_limit` | `medium` | Topics count (500/2500/5000/all) |
| `llms_txt_include_excerpts` | `false` | Include post excerpts in llms-full.txt |
| `llms_txt_post_excerpt_length` | `500` | Maximum excerpt length in characters (100-5000) |
| `llms_txt_latest_topics_count` | `50` | Latest topics count (max 50 recommended) |

**⚠️ WARNING:** Enabling `llms_txt_include_excerpts` with `llms_txt_posts_limit` set to `"all"` may cause:
- Extremely large file sizes (potentially 10-100+ MB)
- High server load during generation
- Long generation times (30+ seconds)
- Memory issues on large forums

**Recommended:** Only enable excerpts with `small` or `medium` post limits. If you have a large forum (10,000+ topics), keep excerpts disabled or use `small` limit.

### Performance Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `llms_txt_cache_minutes` | `60` | Cache duration for navigation file |

---

## 🔬 Advanced Topics

### SEO & Canonical URLs

**We've taken care of search engine duplicate content concerns:**

Every dynamic llms.txt file includes canonical URL information in two ways:

**1. HTTP Link Header:**
```http
Link: <https://forum.com/t/topic-slug/123>; rel="canonical"
```

The server automatically sends a `Link` header with `rel="canonical"` pointing to the original forum resource URL. Search engines and AI crawlers recognize this standard header and understand that:
- The llms.txt file is derivative/supplementary content
- The canonical (original) content is at the forum URL
- They should attribute content to the forum URL, not the llms.txt URL

**2. Content Footer:**
```markdown
**Canonical:** https://forum.com/t/topic-slug/123
**Original content:** https://forum.com/t/topic-slug/123
```

At the bottom of each dynamic llms.txt file, we explicitly state the canonical URL and original content location. This helps:
- AI systems understand content provenance
- Search engines avoid duplicate content penalties
- Users and developers see the source of truth

**Benefits:**
- ✅ No SEO penalty for duplicate content
- ✅ Proper attribution to your forum
- ✅ Search engines index the canonical URL
- ✅ AI systems link back to original content
- ✅ Complies with web standards (RFC 6596)

---

### Bot Control & Blocking

**What it is:**
A setting that allows you to block specific AI crawler bots from accessing your `llms.txt` and `llms-full.txt` files, while still allowing them to access your main forum.

**Why would you want to block bots?**

1. **Quality Control**: Some AI bots provide poor attribution or misrepresent content
2. **Competitive Reasons**: You might not want certain AI services using your content
3. **Bandwidth**: Reduce load from aggressive crawlers
4. **Testing**: Block bots during testing phase before opening to all

**How it works:**

The plugin automatically generates `robots.txt` rules for each blocked bot:

```
# LLM Documentation Files
Allow: /llms.txt
Allow: /llms-full.txt
Allow: /sitemaps.txt
Allow: /c/*/llms.txt
Allow: /t/*/llms.txt
Allow: /tag/*/llms.txt

Sitemap: https://your-forum.com/sitemaps.txt

# Blocked bots for llms.txt files
User-agent: Omgilibot
Disallow: /llms.txt
Disallow: /llms-full.txt
Disallow: /sitemaps.txt
Disallow: /c/*/llms.txt
Disallow: /t/*/llms.txt
Disallow: /tag/*/llms.txt

User-agent: ChatGPT-User
Disallow: /llms.txt
Disallow: /llms-full.txt
Disallow: /sitemaps.txt
Disallow: /c/*/llms.txt
Disallow: /t/*/llms.txt
Disallow: /tag/*/llms.txt
```

**Important:** These bots can still crawl and index your **main forum content** - they're only blocked from the `llms.txt` files.

**How to configure:**

1. Navigate to: Admin → Settings → Plugins → discourse-llms-txt-generator
2. Find: `llms_txt_blocked_user_agents`
3. Enter bot names separated by commas: `Omgilibot, ChatGPT-User, AnotherBot`
4. Save settings
5. Check your `/robots.txt` to verify rules were added

**Common bots you might want to block:**
- `Omgilibot` - Omgili web crawler
- `ChatGPT-User` - OpenAI's ChatGPT crawler (if you prefer API access only)
- `CCBot` - Common Crawl bot
- `anthropic-ai` - Anthropic's crawler
- `Google-Extended` - Google's AI training crawler

**Note:** Bot blocking is advisory - well-behaved bots will respect robots.txt, but malicious crawlers might ignore it.

---

### Smart Cache Management

**How it works:**

The plugin uses intelligent caching to balance performance and freshness:

#### Automatic Hourly Checks

Every hour, a background job runs and checks:
1. **Was there new content?**
   - Checks if any topics were created since last update
   - Checks if any categories were updated since last update

2. **If YES → Update cache:**
   - Clears old cached navigation
   - Regenerates `llms.txt` with new content
   - Updates timestamp
   - Logs: `[llms.txt] Updating cache due to new content`

3. **If NO → Skip update:**
   - Keeps existing cache
   - Saves server resources
   - Logs: `[llms.txt] No new content, skipping cache update`

#### Manual Cache Clear

Cache is also cleared immediately when:
- A new post is created
- A post is edited
- Settings are changed

#### Why This Matters

**Old approach (every request):**
```
User requests /llms.txt
  → Generate file (slow, 1-2 seconds)
  → Return to user
Every request = regeneration!
```

**New approach (smart caching):**
```
Hourly job runs:
  → Check: "New topics since last hour?"
  → NO: Skip regeneration (save resources)
  → YES: Regenerate and cache

User requests /llms.txt:
  → Return cached version (instant, <50ms)
```

**Benefits:**
- ✅ Files stay fresh (max 1 hour old)
- ✅ Faster response times (cached)
- ✅ Less server load (only regenerate when needed)
- ✅ Automatic updates (no manual intervention)

#### Monitoring Cache Updates

Check logs to see cache activity:
```bash
tail -f /var/www/discourse/logs/production.log | grep llms.txt
```

You'll see:
```
[llms.txt] Updating cache due to new content
[llms.txt] Cache updated successfully
```
or
```
[llms.txt] No new content, skipping cache update
```

---

### Performance Optimization

#### Caching

- Navigation file (`llms.txt`) is cached for 60 minutes by default
- Full content file is generated on-demand (not cached due to size)
- Cache is automatically cleared when posts are created/edited

#### Optimization Tips

1. **Set appropriate limits**: Don't include all content if you have a large forum
2. **Adjust minimum views**: Filter out low-quality topics
3. **Monitor access**: Check analytics to see how often files are accessed
4. **Use CDN**: Consider CDN caching for frequently accessed files

#### Resource Usage

- Small forum (<1000 topics): Negligible impact
- Medium forum (1000-10000 topics): ~1-2 seconds generation time for full file
- Large forum (>10000 topics): Use "small" or "medium" posts_limit setting

---

### Custom Forum Description

**What is it?**
An optional text field that appears at the top of your `llms-full.txt` file, right after the site title and description.

**Why do you need it?**
LLMs work best when they have clear context about what your forum is about. This field allows you to provide:
- The main purpose of your forum
- What topics are discussed
- Who your target audience is
- Any special focus areas or expertise

**What to write:**
✅ **GOOD examples:**
```
This forum is dedicated to discussing Python programming, with focus on
web development, data science, and machine learning. Our community includes
beginners and experienced developers sharing practical solutions and best practices.
```

```
A technical support community for XYZ Software users. We help troubleshoot
installation issues, configuration problems, and provide guides for advanced features.
Members range from new users to certified administrators.
```

❌ **BAD examples (avoid these):**
```
🎉 Join the BEST community ever! 🚀 Amazing discussions!
Limited time offer - sign up now! [This is marketing spam]
```

```
We are the world's leading #1 forum with millions of experts!
[This is exaggeration/false claims]
```

**How LLMs use this:**
When an LLM reads your `llms-full.txt`, it first reads this description to understand the context. This helps it:
- Give more accurate answers about your forum
- Better match user queries to your content
- Understand the expertise level of discussions

**Configuration:**
- Navigate to: Admin → Settings → Plugins → discourse-llms-txt-generator
- Find: `llms_txt_full_description`
- Enter: 2-4 sentences describing your forum factually
- Leave empty if you don't need it (optional field)

---

### Integration with Discourse

#### Robots.txt

The plugin automatically adds entries to robots.txt via view connector:

```
# LLM Documentation Files
Allow: /llms.txt
Allow: /llms-full.txt
Allow: /sitemaps.txt
Allow: /c/*/llms.txt
Allow: /t/*/llms.txt
Allow: /tag/*/llms.txt

Sitemap: https://your-forum.com/sitemaps.txt
```

Or if indexing is disabled:

```
# LLM Documentation Files
Disallow: /llms.txt
Disallow: /llms-full.txt
Disallow: /sitemaps.txt
Disallow: /c/*/llms.txt
Disallow: /t/*/llms.txt
Disallow: /tag/*/llms.txt
```

#### Sitemap.xml

Automatically adds entries to sitemap:

```xml
<url>
  <loc>https://your-forum.com/llms.txt</loc>
  <priority>1.0</priority>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>https://your-forum.com/llms-full.txt</loc>
  <priority>0.9</priority>
  <changefreq>weekly</changefreq>
</url>
<url>
  <loc>https://your-forum.com/sitemaps.txt</loc>
  <priority>0.8</priority>
  <changefreq>weekly</changefreq>
</url>
```

#### Analytics

The plugin tracks:
- Access count for each file
- Last access timestamp
- User agent (via server logs)

Access stats via Rails console:

```ruby
PluginStore.get("discourse-llms-txt-generator", "access_count_index")
PluginStore.get("discourse-llms-txt-generator", "access_count_full")
PluginStore.get("discourse-llms-txt-generator", "last_access_index")
```

---

## 🔒 Privacy & Security

### Private Content Protection

**Your private categories and topics are SAFE**:

✅ **Private categories** (`read_restricted: true`) are **completely excluded** from:
- `/llms.txt` - Latest topics list
- `/llms-full.txt` - Full content index
- `/sitemaps.txt` - Sitemap index
- `/tag/{name}/llms.txt` - Tag-based topic lists

✅ **Topics from private categories** will **never appear** in public llms.txt files

✅ **Dynamic files** (per-category/topic) use **Guardian permission checks**:
- `/c/{category}/llms.txt` → Returns 404 for unauthorized users
- `/t/{topic}/llms.txt` → Returns 404 for unauthorized users

✅ **Automatic updates**: When you change a category from private to public, topics automatically appear in public files (within cache refresh time)

### Security Features

- **Respects Discourse Permissions**: Only includes publicly accessible content
- **No Authentication Required**: Public files work like sitemaps
- **No Personal Data**: Only publicly visible forum content
- **CSRF Safe**: All security checks properly handled
- **No XSS Risk**: Content is served as plain text
- **Category-Level Filtering**: SQL-level filtering ensures private topics never leak

---

## 🐛 Troubleshooting

### Issue: Files not accessible

**Symptoms:**
- `/llms.txt` returns 404
- `/llms-full.txt` not found

**Solutions:**

1. **Check plugin is enabled:**
   ```
   Admin → Settings → Plugins → llms_txt_enabled = true
   ```

2. **Verify indexing is allowed:**
   ```
   Admin → Settings → llms_txt_allow_indexing = true
   ```

3. **Check plugin installation:**
   ```
   Admin → Plugins → Look for "discourse-llms-txt-generator"
   ```

4. **Check logs:**
   ```bash
   tail -f /var/www/discourse/logs/production.log | grep llms
   ```

---

### Issue: Empty or incomplete content

**Symptoms:**
- Files exist but show no topics
- Missing categories

**Solutions:**

1. **Verify you have public topics with sufficient views:**
   - Topics must have at least `llms_txt_min_views` views (default 50)

2. **Check minimum views setting:**
   ```
   Admin → Settings → llms_txt_min_views
   ```
   If too high, lower it to include more topics

3. **Check posts limit:**
   ```
   Admin → Settings → llms_txt_posts_limit
   ```
   Try changing to "medium" or "all"

4. **Ensure categories are public:**
   - Private categories (`read_restricted: true`) are excluded
   - Check: Admin → Categories → [Category] → Security

---

### Issue: Performance issues

**Symptoms:**
- Slow generation times
- High server load
- Timeouts

**Solutions:**

1. **Reduce posts limit:**
   ```
   Admin → Settings → llms_txt_posts_limit = "small" or "medium"
   ```

2. **Increase minimum views:**
   ```
   Admin → Settings → llms_txt_min_views = 100
   ```
   Filter out low-quality topics

3. **Disable excerpts:**
   ```
   Admin → Settings → llms_txt_include_excerpts = false
   ```

4. **Increase cache duration:**
   ```
   Admin → Settings → llms_txt_cache_minutes = 120
   ```

---

### Issue: robots.txt doesn't show llms.txt entries

**Symptoms:**
- `curl https://forum.com/robots.txt` doesn't show "LLM Documentation Files"

**Solutions:**

1. **Clear robots.txt cache:**
   ```bash
   cd /var/www/discourse
   rails runner "Rails.cache.delete('robots_txt')"
   ```

2. **Use plugin rake task:**
   ```bash
   bundle exec rake llms_txt:refresh
   ```

3. **Restart Discourse:**
   ```bash
   cd /var/discourse
   ./launcher restart app
   ```

4. **Verify after 30 seconds:**
   ```bash
   curl https://your-forum.com/robots.txt | grep -A 10 "LLM Documentation"
   ```

---

## 🤝 Support & Contributing

### Getting Help

- 📧 Email: support@kaktak.net
- 💬 Discourse Meta: [Plugin Topic](https://meta.discourse.org/t/discourse-llms-txt-generator)
- 🐛 Issues: [GitHub Issues](https://github.com/kaktaknet/discourse-llms-txt-generator/issues)

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Development setup and testing
- Architecture and how the plugin works internally
- Code guidelines and standards
- How to submit changes

**Quick contribution guide:**
1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

---

## 📝 Changelog

### Version 1.2.0 (2025-11-11)

**Bug Fixes:**
- 🐛 Fixed critical robots.txt integration bug - replaced non-existent `:robots_txt` event with view connector
- 🐛 Fixed URL encoding for Cyrillic and international characters (RFC 3986 compliance)
- 🐛 Fixed compatibility with Discourse 3.6.0.beta3 and different versions

**Major Features:**
- ✨ Added canonical URLs in HTTP Link headers (RFC 6596)
- ✨ Added canonical URL footers in dynamic llms.txt files
- ✨ Proper SEO protection against duplicate content penalties

**Improvements:**
- 🔧 Improved sitemap integration using DiscourseEvent hooks
- 🔧 Added rake tasks for maintenance (`llms_txt:refresh`, `llms_txt:check`)
- 🔧 Enhanced CONTRIBUTING.md with sitemap/robots testing documentation

### Version 1.0.0 (2025-11-08)

- Initial release
- Basic llms.txt navigation generation
- Full llms-full.txt content generation
- Configurable settings
- Robots.txt and sitemap.xml integration
- Caching support
- Analytics tracking
- Multi-language foundation (English)

---

## 📄 License

**MIT License**

This is free, open-source software. Use it, modify it, share it!

See [LICENSE](LICENSE) file for details.

---

## 🌟 Credits

- **Author**: KakTak.net
- **Standard**: [llms.txt by Jeremy Howard (Answer.AI)](https://llmstxt.org/)
- **Platform**: [Discourse](https://www.discourse.org/)

---

Made with ❤️ for the Discourse community
