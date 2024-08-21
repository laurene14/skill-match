import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe"
export default class extends Controller {
  static targets = ["card"]

  currentUserId = null;

  connect() {
    console.log("connected");
    this.currentUserId = parseInt(document.body.dataset.currentUserId, 10);
    this.initCards(true);
    this.cardTargets.forEach((card) => {
      this.initCard(card);
    });
  }

  initCards(first_init) {
    const activeCards = this.cardTargets.filter(card => !card.classList.contains("removed"));
    activeCards.forEach((card, index) => {
      card.style.zIndex = activeCards.length - index;
      // line below can generate the card pile in another way
      // card.style.transform = 'scale(' + (20 - index) / 20 + ') translateY(-' + 24 * index + 'px)';
      card.style.opacity = (10 - index) / 10;
      if (first_init && index !== 0) {
        const randomRotation = (Math.random() * 12) - 6;
        card.style.transform = ` rotate(${randomRotation}deg)`;
      } else if (!first_init && index == 0) {
        card.style.transform = 'rotate(0deg)'
      }
    });
    this.element.classList.add('loaded');
  }


  initCard(card) {
    const hammertime = new Hammer(card);

    hammertime.on('pan', (event) => {
      if (event.pointers.length > 1) {
        return;
      }
      event.preventDefault();
      card.classList.add('moving');

      if (event.daltaX === 0) return;
      if (event.center.x === 0 && event.center.y === 0) return;

      this.handleToggleStatusClass(event);

      var xMulti = event.deltaX * 0.03;
      var yMulti = event.deltaY / 80;
      var rotate = xMulti * yMulti;

      card.style.transform = 'translate(' + event.deltaX + 'px, ' + event.deltaY + 'px) rotate(' + rotate + 'deg)';
    });

    hammertime.on('panend', (event) => {
      card.classList.remove('moving');

      var moveOutWidth = document.body.clientWidth;
      var keep = Math.abs(event.deltaX) < 80 || Math.abs(event.velocityX) < 0.5;
      card.classList.toggle('removed', !keep);

      this.handleRemoveStatusClass(event, !keep);
      if (keep) {
        card.style.transform = '';
      } else {
        var endX = Math.max(Math.abs(event.velocityX) * moveOutWidth, moveOutWidth);
        var toX = event.deltaX > 0 ? endX : -endX;
        var endY = Math.abs(event.velocityY) * moveOutWidth;
        var toY = event.deltaY > 0 ? endY : -endY;
        var xMulti = event.deltaX * 0.03;
        var yMulti = event.deltaY / 80;
        var rotate = xMulti * yMulti;

        card.style.transform = 'translate(' + toX + 'px, ' + (toY + event.deltaY) + 'px) rotate(' + rotate + 'deg)';
        this.initCards(false);
      }
    })
  };

  handleToggleStatusClass(event) {
    this.element.classList.toggle('swipe--accept', event.deltaX > 0);
    this.element.classList.toggle('swipe--refuse', event.deltaX < 0);
  }

  handleRemoveStatusClass(event, leave) {
    if (this.element.classList.contains('swipe--accept')) {
      this.element.classList.remove('swipe--accept');
      if (leave) {
        this.handleAccept(event.target.parentElement);
      }
    } else {
      this.element.classList.remove('swipe--refuse');
      if (leave) {
        this.handleRefuse(event.target.parentElement);
      }
    }
  }

  clickAccept(event) {
    this.handleClickStatusButton(event, 1);
    event.preventDefault();
  }
  clickRefuse(event) {
    this.handleClickStatusButton(event, 2)
    event.preventDefault();
  }

  clickFollow(event) {
    this.handleClickStatusButton(event, 3)
    event.preventDefault();
  }

  handleClickStatusButton(event, status) {
    const activeCards = this.cardTargets.filter(card => !card.classList.contains("removed"));
    const moveOutWidth = document.body.clientWidth * 1.5
    if (!activeCards.length) return false;
    var card = activeCards[0];
    card.classList.add('removed');
    if (status === 1) {
      card.style.transform = 'translate(' + moveOutWidth + 'px, -100px) rotate(-30deg)';
      this.handleAccept(activeCards[0]);
    } else if (status === 2) {
      card.style.transform = 'translate(-' + moveOutWidth + 'px, -100px) rotate(30deg)';
      this.handleRefuse(activeCards[0]);
    } else if (status === 3) {
      var moveOutHeight = document.body.clientHeight;
      card.style.transform = 'translateY(-' + moveOutHeight + 'px)';
      this.handleFollow(activeCards[0]);
    }
    this.initCards(false);
  }

  handleRefuse(card) {
    console.log("refuse");
    console.log(this.currentUserId);
    console.log(card.id);
    const url = '/likes'
    const options = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        "liker_id": this.currentUserId,
        "liked_id": card.id,
        "wanted": false
      })
    }
    fetch(url, options)
    .then(response => response.json())
    .then(data => console.log(data))
  }

  handleAccept(card) {
    console.log("accept")
    console.log(this.currentUserId)
    console.log(card.id)

  }

  handleFollow(card) {
    console.log("follow")
    console.log(this.currentUserId)
    console.log(card.id)

  }

}
